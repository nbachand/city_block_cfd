"""
Monte Carlo verification of the fluctuation corrections (Section 3.3).

Notes
-----
1. Ventilation-form H uses the arithmetic mean of |q'|:
       H(q) = mean(|q'|) / |q_MP|
   This is the leading-order result when symmetric flow fluctuations are
   specified directly. The old harmonic form, 1/mean(|q'|^-1) / |q_MP|, is the
   pressure result rewritten in flow variables; it only applies to
   pressure-driven fluctuations and diverges for Gaussian q'.
   The pressure-form H is unchanged (harmonic mean of sqrt|dp'|).
2. The regime scalings (mean-dominated sqrt(1 - I^2), fluctuation-dominated
   1/(2H), and the piecewise models) come from pyafn, which is the single
   source of truth for the model. H_U and H_T are evaluated locally only so
   they can be plotted; pyafn uses the same expressions internally.
3. The full figure has a fourth row showing relative error against Monte Carlo,
   which shows errors that are invisible on the linear q_n axis at large I.
"""

import numpy as np
import matplotlib.pyplot as plt
import pyafn


def _as_scalar(x):
    """Call array-oriented pyafn functions with scalar values safely."""
    return np.asarray(x).reshape(-1)[0]


def _scale_scalar(func, x):
    return _as_scalar(func(np.array([x], dtype=float)))


# Constants
C_d = pyafn.Cd  # Discharge coefficient
A = 1           # Area (m^2)
rho = 1.225     # Air density (kg/m^3)
U_10 = 1.0      # Prescribed velocity at 10 m height (m/s), used for nondimensionalization
N_SAMPLES = 10**8  # Number of Monte Carlo samples

# Which power mean defines H in each form.
H_MEAN_Q = 'arithmetic'  # ventilation form: mean |q'|  (old, incorrect: 'harmonic')
H_MEAN_P = 'harmonic'    # pressure form: harmonic mean of sqrt|dp'|

# Piecewise-model constants fixed by the tangency condition (match pyafn defaults).
I_STAR_Q = 1 / np.sqrt(2)
I_STAR_P = 1 / np.sqrt(3)
K_TANGENT_P = 3 * np.sqrt(3) / 8


# ---------------------------------------------------------------------------
# Orifice equation (pyafn)
# ---------------------------------------------------------------------------
def q_AFN(Delta_p_mean):
    """Airflow network prediction"""
    return pyafn.flowFromP(C_d, A, Delta_p_mean)


def p_instantaneous(q):
    """Instantaneous pressure from flow"""
    return pyafn.pFromFlow(C_d, A, q)


# ---------------------------------------------------------------------------
# Regime scalings (pyafn) and H models for plotting
# ---------------------------------------------------------------------------
def mean_dominated_scaling(I):
    """q_bar / q_MP = sqrt(1 - I^2); 0 for I >= 1."""
    return pyafn.ventilationUpperScaling(np.asarray(I, dtype=float))


def fluctuation_dominated_scaling(H):
    """q_bar / q_MP = 1 / (2H)."""
    with np.errstate(divide='ignore'):
        return pyafn.ventilationLowerScaling(np.asarray(H, dtype=float))


def piecewise_scaling(I, use_pressure):
    """Combined model: mean-dominated below I*, fluctuation-dominated above."""
    blended_func = pyafn.ventilationBlendedScaling_p if use_pressure else pyafn.ventilationBlendedScaling_q
    return blended_func(np.asarray(I, dtype=float))


def H_upper(I, use_pressure):
    """Upper bound H_U from power-mean monotonicity."""
    I = np.asarray(I, dtype=float)
    return np.sqrt(2 * I) if use_pressure else I


def H_tangent(I, use_pressure):
    """H_U scaled so the two branches meet tangentially."""
    I = np.asarray(I, dtype=float)
    return np.sqrt(K_TANGENT_P * I) if use_pressure else I


def piecewise_transition_intensity(use_pressure):
    """Return the switch used by the corresponding piecewise model."""
    return I_STAR_P if use_pressure else I_STAR_Q


# ---------------------------------------------------------------------------
# Monte Carlo sampling
# ---------------------------------------------------------------------------
def monte_carlo_average_pressure(Delta_p_mean, Delta_p_std, n_samples=100000):
    """Sample pressure from a normal distribution; flows via the orifice equation."""
    Delta_p_samples = np.random.normal(Delta_p_mean, Delta_p_std, n_samples)
    q_samples = q_AFN(Delta_p_samples)
    return q_samples, Delta_p_samples


def monte_carlo_average_flow(q_mean, q_std, n_samples=100000):
    """Sample flow from a normal distribution; pressures via the inverse orifice equation."""
    q_samples = np.random.normal(q_mean, q_std, n_samples)
    Delta_p_samples = p_instantaneous(q_samples)
    return q_samples, Delta_p_samples


# ---------------------------------------------------------------------------
# Statistics
# ---------------------------------------------------------------------------
def power_mean(x, kind):
    if kind == 'harmonic':
        with np.errstate(divide='ignore'):
            return 1 / np.mean(1 / x)
    if kind == 'geometric':
        with np.errstate(divide='ignore'):
            return np.exp(np.mean(np.log(x)))
    if kind == 'arithmetic':
        return np.mean(x)
    if kind == 'quadratic':
        return np.sqrt(np.mean(x**2))
    raise ValueError(f"Unknown mean type: {kind}")


def calculate_statistics(q_samples, Delta_p_samples, q_mean_type=H_MEAN_Q, p_mean_type=H_MEAN_P):
    q_mean = np.mean(q_samples)
    q_prime = q_samples - q_mean
    q_prime_rms = np.sqrt(np.mean(q_prime**2))
    q_prime_H_mean = power_mean(np.abs(q_prime), q_mean_type)  # mean |q'| by default

    Delta_p_mean = np.mean(Delta_p_samples)
    Delta_p_prime = Delta_p_samples - Delta_p_mean
    Delta_p_prime_rms = np.sqrt(np.mean(Delta_p_prime**2))
    Delta_p_prime_H_mean = power_mean(np.sqrt(np.abs(Delta_p_prime)), p_mean_type)  # harmonic by default

    return q_mean, q_prime_rms, q_prime_H_mean, Delta_p_mean, Delta_p_prime_rms, Delta_p_prime_H_mean


# ---------------------------------------------------------------------------
# Run and plot
# ---------------------------------------------------------------------------
fig, axes = plt.subplots(4, 2, figsize=(10.2, 10), sharex='col',
                         gridspec_kw={'height_ratios': [2, 1, 1, 1]})
fig_top, axes_top = plt.subplots(1, 2, figsize=(10.2, 5), sharex=False)

for i, usePressure in enumerate([False, True]):
    # False: ventilation-based (sample q); True: pressure-based (sample dp)

    # Match the original dimensional sampling ranges.
    q_std = 1.0   # Flow standard deviation (m^3/s)
    min_q = 0.01  # Minimum sampled mean flow (m^3/s)
    max_q = 3.0   # Maximum sampled mean flow and maximum pressure-based q_MP (m^3/s)
    # This sets q_AFN(p_std / 2) = q_std, matching the fluctuation reference scales.
    p_std = 2 * _scale_scalar(p_instantaneous, q_std)
    if usePressure:
        base_std = p_std
        min_value = p_std * min_q / q_std
        max_value = _scale_scalar(p_instantaneous, max_q)
    else:
        base_std = q_std
        min_value = min_q
        max_value = max_q
    means = np.logspace(np.log10(min_value), np.log10(max_value), 40)

    mc_q_mean = []
    I_values, I_q_values, I_p_values = [], [], []
    H_values = []
    q_mp_values = []

    print("Running Monte Carlo simulations...")
    for mean in means:
        if usePressure:
            qs, delPs = monte_carlo_average_pressure(mean, base_std, n_samples=N_SAMPLES)
        else:
            qs, delPs = monte_carlo_average_flow(mean, base_std, n_samples=N_SAMPLES)

        (q_mean_mc, q_prime_rms, q_prime_H_mean,
         Delta_p_mean_mc, Delta_p_prime_rms, Delta_p_prime_H_mean) = calculate_statistics(qs, delPs)
        q_mp = _as_scalar(q_AFN(Delta_p_mean_mc))
        I_q = q_prime_rms / np.abs(q_mp)
        I_p = Delta_p_prime_rms / (2 * np.abs(Delta_p_mean_mc))
        I = I_p if usePressure else I_q

        if usePressure:
            H = Delta_p_prime_H_mean / np.sqrt(np.abs(Delta_p_mean_mc))
        else:
            H = q_prime_H_mean / np.abs(q_mp)

        I_values.append(I)
        I_q_values.append(I_q)
        I_p_values.append(I_p)
        H_values.append(H)
        q_mp_values.append(q_mp)
        mc_q_mean.append(q_mean_mc)

        if len(mc_q_mean) % 5 == 0:
            print(f"I={I:.3f}, H={H:.3f}, dp_mean={Delta_p_mean_mc:.3f}, "
                  f"q/q_MP (MC)={q_mean_mc / q_mp:.4f}, "
                  f"q/q_MP (PW)={_as_scalar(piecewise_scaling([I], usePressure)):.4f}")

    I_values = np.array(I_values)
    I_q_values = np.array(I_q_values)
    I_p_values = np.array(I_p_values)
    H_values = np.array(H_values)
    q_mp_values = np.array(q_mp_values)
    mc_q_mean = np.array(mc_q_mean)

    H_bound_values = H_upper(I_values, usePressure)
    H_tangent_values = H_tangent(I_values, usePressure)

    # Model predictions as q_bar / q_MP
    F_mean_dom = mean_dominated_scaling(I_values)
    F_fluct_H = fluctuation_dominated_scaling(H_values)
    F_fluct_HU = fluctuation_dominated_scaling(H_bound_values)
    F_piecewise = piecewise_scaling(I_values, usePressure)

    # Axes and labels
    if usePressure:
        x_star_label = r'$I^*(\Delta C_p)^{-1/2}$'
        x_label = r'$I(\Delta C_p)^{-1/2}$'
        exponent = -0.5
        title = r'Pressure-based; $\Delta C_p \sim \mathcal{N}(\overline{\Delta C_p}, \sigma_{\Delta C_p}^2)$'
    else:
        x_star_label = r'$I^*(q_n)^{-1}$'
        x_label = r'$I(q_n)^{-1}$'
        exponent = -1.0
        title = r'Ventilation-based; $q_n \sim \mathcal{N}(\overline{q}_n, \sigma_{q_n}^2)$'
    x_star = piecewise_transition_intensity(usePressure)**exponent
    x_vals = I_values**exponent

    # Nondimensionalize ventilation rates: q_n = q / (U_10 A).
    q_ref = U_10 * A
    y_mc = mc_q_mean / q_ref
    q_mp_n = q_mp_values / q_ref

    # Row 1: mean ventilation rate
    for ax in (axes[0, i], axes_top[i]):
        ax.plot(x_vals, y_mc, 'kx', label='Monte Carlo', markersize=6)
        ax.plot(x_vals, q_mp_n, color='red', linestyle='--', label='$\\overline{q}_n = q_{MP,n}$', linewidth=1)
        ax.plot(x_vals, F_mean_dom * q_mp_n, color='blue', linestyle='--', label='$\\overline{q}_n = q_{MP,n}\\sqrt{1-I^2}$', linewidth=2.5)
        ax.plot(x_vals, F_fluct_H * q_mp_n, color='green', linestyle=':', label='$\\overline{q}_n = q_{MP,n}/(2H)$', linewidth=2.5)
        ax.plot(x_vals, F_fluct_HU * q_mp_n, color='green', linestyle='--', label='$\\overline{q}_n = q_{MP,n}/(2H_{\\mathrm{U}})$', linewidth=2.5)
        ax.plot(x_vals, F_piecewise * q_mp_n, color='black', linestyle='-', label='$\\overline{q}_n = q_{\\mathrm{PW},n}$', linewidth=1.5)
        ax.axvline(x_star, color='0.35', linestyle='-.', linewidth=1.25)
        x_min, x_max = ax.get_xlim()
        ax.text((x_min + x_star) / 2, 0.95, 'Fluctuation Dominated',
                transform=ax.get_xaxis_transform(), ha='center', va='top', fontsize=10,
                bbox=dict(facecolor='white', edgecolor='none', pad=2))
        ax.text((x_star + x_max) / 2, 0.95, 'Mean Dominated',
                transform=ax.get_xaxis_transform(), ha='center', va='top', fontsize=10,
                bbox=dict(facecolor='white', edgecolor='none', pad=2))
        ax.annotate(x_star_label, xy=(x_star, 0.90),
                    xycoords=('data', 'axes fraction'), xytext=(5, 0),
                    textcoords='offset points', ha='left', va='top', fontsize=11,
                    bbox=dict(facecolor='white', edgecolor='none', pad=1))
        ax.set_xlabel(x_label, fontsize=14)
        ax.set_ylabel(r'$\overline{q}_n$', fontsize=14)
        ax.set_title(title, fontsize=16, fontweight='normal')
        if i == 0:
            ax.legend(fontsize=11, loc='lower right')
        ax.grid(True, alpha=0.3)
        ax.set_ylim([0, 1.1 * max(np.max(y_mc), np.max(q_mp_n))])

    # Row 2: intensity values
    ax = axes[1, i]
    ax.plot(x_vals, 1 / I_p_values, color='#0072B2', linestyle='-', label='$I(\\Delta C_p)^{-1}$', linewidth=2)
    ax.plot(x_vals, 1 / I_q_values, color='#D55E00', linestyle='-', label='$I(q_n)^{-1}$', linewidth=2)
    ax.set_xlabel(x_label, fontsize=14)
    ax.set_ylabel('$I^{-1}$', fontsize=14)
    if i == 0:
        ax.legend(fontsize=11, loc='lower right')
    ax.grid(True, alpha=0.3)

    # Row 3: H values
    ax = axes[2, i]
    ax.plot(x_vals, 1 / H_values, color='#D55E00', linestyle='-', label='$H^{-1}$', linewidth=2)
    ax.plot(x_vals, 1 / H_bound_values, color='#0072B2', linestyle=':', label='$H_{\\mathrm{U}}^{-1}$', linewidth=2)
    ax.plot(x_vals, 1 / H_tangent_values, color='#009E73', linestyle='--', label='$H_{\\mathrm{T}}^{-1}$', linewidth=2)
    ax.set_xlabel(x_label, fontsize=14)
    ax.set_ylabel('$H^{-1}$', fontsize=14)
    if i == 0:
        ax.legend(fontsize=11, loc='lower right')
    ax.grid(True, alpha=0.3)
    ax.set_ylim(bottom=0)

    # Row 4: relative error against Monte Carlo
    F_mc = mc_q_mean / q_mp_values
    err_pw = 100 * (F_piecewise / F_mc - 1)
    err_fluct_H = 100 * (F_fluct_H / F_mc - 1)
    ax = axes[3, i]
    ax.plot(x_vals, err_pw, color='black', linestyle='-', label='$q_{\\mathrm{PW},n}$', linewidth=1.5)
    ax.plot(x_vals, err_fluct_H, color='green', linestyle=':', label='$q_{MP,n}/(2H)$', linewidth=2)
    ax.axhline(0, color='0.35', linewidth=0.8)
    ax.axvline(x_star, color='0.35', linestyle='-.', linewidth=1.25)
    ax.set_xlabel(x_label, fontsize=14)
    ax.set_ylabel('Error (%)', fontsize=14)
    ax.set_ylim([-30, 30])
    if i == 0:
        ax.legend(fontsize=11, loc='lower right')
    ax.grid(True, alpha=0.3)

    j = np.argmax(np.abs(err_pw))
    print(f"{'Pressure' if usePressure else 'Ventilation'}-based: max piecewise error "
          f"{err_pw[j]:.1f}% at I = {I_values[j]:.3f}")

for ax in (*axes.flat, *axes_top.flat):
    for axis in (ax.xaxis, ax.yaxis):
        axis.label.set_fontsize(1.25 * axis.label.get_fontsize())
        axis.get_offset_text().set_fontsize(1.25 * axis.get_offset_text().get_fontsize())
        for tick in axis.get_major_ticks() + axis.get_minor_ticks():
            tick.label1.set_fontsize(1.25 * tick.label1.get_fontsize())
            tick.label2.set_fontsize(1.25 * tick.label2.get_fontsize())

fig.tight_layout()
fig_top.tight_layout()

fig.savefig('monte_carlo_square_root_non_linearity.png', dpi=300)
fig_top.savefig('monte_carlo_square_root_non_linearity_top_row.png', dpi=300)
plt.show()
