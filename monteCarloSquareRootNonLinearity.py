import numpy as np
import matplotlib.pyplot as plt
import pyafn


def _as_scalar(x):
    """Call array-oriented pyafn scaling functions with scalar values safely."""
    return np.asarray(x).reshape(-1)[0]


def _scale_scalar(func, x):
    return _as_scalar(func(np.array([x], dtype=float)))

# Constants
C_d = 0.611  # Discharge coefficient
A = 1      # Area (m^2)
rho = 1.225    # Air density (kg/m^3)
U_10 = 1.0     # Prescribed velocity at 10 m height (m/s), used for nondimensionalization
H_mean_type='harmonic'  # 'harmonic', 'geometric', 'arithmetic', or 'quadratic' mean for H calculation
N_SAMPLES = 10**8  # Number of Monte Carlo samples

def q_AFN(Delta_p_mean):
    """Airflow network prediction"""
    return pyafn.flowFromP(C_d, A, Delta_p_mean)

def p_instantaneous(q):
    """Instantaneous pressure from flow"""
    return pyafn.pFromFlow(C_d, A, q)

def monte_carlo_average_pressure(Delta_p_mean, Delta_p_std, n_samples=100000):
    """
    Monte Carlo simulation of average flow
    
    Parameters:
    -----------
    Delta_p_mean : float
        Mean pressure difference (Pa)
    Delta_p_std : float
        Standard deviation of pressure fluctuations (Pa)
        """

    # Sample pressure from normal  distribution
    Delta_p_samples = np.random.normal(Delta_p_mean, Delta_p_std, n_samples)
    
    # Calculate instantaneous flows
    q_samples = q_AFN(Delta_p_samples)
    return q_samples, Delta_p_samples

def monte_carlo_average_flow(q_mean, q_std, n_samples=100000):
    # Sample flow from normal distribution
    q_samples = np.random.normal(q_mean, q_std, n_samples)
    
    # Calculate instantaneous pressures
    Delta_p_samples = p_instantaneous(q_samples)
    return q_samples, Delta_p_samples

def harmonic_mean(x):
    return 1/np.mean(x**(-1))

def geometric_mean(x):
    return np.exp(np.mean(np.log(x)))


def piecewise_transition_intensity(use_pressure):
    """Return the switch used by the corresponding piecewise model."""
    return 1 / np.sqrt(3) if use_pressure else 1 / np.sqrt(2)

def calculate_statistics(q_samples, Delta_p_samples, H_mean_type='harmonic'):
    # Calculate statistics
    q_mean = np.mean(q_samples)
    q_prime = q_samples - q_mean
    q_prime_rms = np.sqrt(np.mean(q_prime**2))
    q_prime_H = np.abs(q_prime)

    Delta_p_mean = np.mean(Delta_p_samples)
    Delta_p_prime = Delta_p_samples - Delta_p_mean
    Delta_p_prime_rms = np.sqrt(np.mean(Delta_p_prime**2))
    Delta_p_prime_H = np.sqrt(np.abs(Delta_p_prime))

    if H_mean_type == 'harmonic':
        q_prime_H_mean = harmonic_mean(q_prime_H)  # Harmonic mean of |q'|
        Delta_p_prime_H_mean = harmonic_mean(Delta_p_prime_H)  # Harmonic mean of sqrt(|Δp'|)^-1
    elif H_mean_type == 'geometric':
        q_prime_H_mean = geometric_mean(q_prime_H)  # Geometric mean of |q'|
        Delta_p_prime_H_mean = geometric_mean(Delta_p_prime_H)  # Geometric mean of sqrt(|Δp'|)^-1
    elif H_mean_type == 'arithmetic':
        q_prime_H_mean = np.mean(q_prime_H)  # Arithmetic mean of |q'|
        Delta_p_prime_H_mean = np.mean(Delta_p_prime_H)  # Arithmetic mean of sqrt(|Δp'|)^-1
    elif H_mean_type == 'quadratic':
        q_prime_H_mean = np.sqrt(np.mean(q_prime_H**2))  # Quadratic mean of |q'|
        Delta_p_prime_H_mean = np.sqrt(np.mean(Delta_p_prime_H**2))  # Quadratic mean of sqrt(|Δp'|)^-1
    
    return q_mean, q_prime_rms, q_prime_H_mean, Delta_p_mean, Delta_p_prime_rms, Delta_p_prime_H_mean
    
fig, axes = plt.subplots(3, 2, figsize=(10.2, 8), sharex='col', gridspec_kw={'height_ratios': [2, 1, 1]})
# The top row occupies 2/(2+1+1) of the full figure height, so 10 x 4 inches
# preserves the same nominal panel width and height in the standalone version.
fig_top, axes_top = plt.subplots(1, 2, figsize=(10.2, 5), sharex=False)
for i, usePressure in enumerate([False, True]):
    HPressure = usePressure  # Set to True ts use pressure-based H definition
    QPressure = usePressure  # Set to True to use pressure-based Q definition
    randomPressure = usePressure  # Set to True to sample pressure, False to sample flow

    # Match the original dimensional sampling ranges.
    q_std = 1.0  # Flow standard deviation (m^3/s)
    min_q = 0.01  # Minimum sampled mean flow (m^3/s)
    max_q = 3.0  # Maximum sampled mean flow and maximum pressure-based q_MP (m^3/s)
    # This sets q_AFN(p_std / 2) = q_std, matching the fluctuation reference scales.
    p_std = 2 * _scale_scalar(p_instantaneous, q_std)
    if randomPressure:
        base_std = p_std
        min_value = p_std * min_q / q_std
        max_value = _scale_scalar(p_instantaneous, max_q)
    else:
        base_std = q_std
        min_value = min_q
        max_value = max_q
    means = np.logspace(np.log10(min_value), np.log10(max_value), 40)

    # Storage for results
    mc_q_mean = []
    mc_q_mean_normalized = []
    analytical_mean_dom = []
    analytical_fluct_dom = []
    analytical_fluct_dom_bound = []
    analytical_fluct_tan = []
    analytical_blend = []
    analytical_AFN = []

    print("Running Monte Carlo simulations...")

    I_values = []
    I_q_values = []
    I_p_values = []
    H_values = []
    H_bound_values = []
    H_tangent_values = []
    q_afn_values = []
    for mean in means:

        if randomPressure:
            # Monte Carlo simulation
            qs, delPs = monte_carlo_average_pressure(
                mean, base_std, n_samples=N_SAMPLES
            )
        else:
            # Monte Carlo simulation
            qs, delPs = monte_carlo_average_flow(
                mean, base_std, n_samples=N_SAMPLES
            )

        # plt.figure()
        # plt.hist(qs, bins=50, alpha=0.1, label='q')
        # plt.hist(delPs, bins=50, alpha=0.1, label='P')
        # plt.title(f"mean={mean:.3f}", fontsize=14)
        # plt.legend()
        # plt.show()

        q_mean_mc, q_prime_rms, q_prime_H_mean, Delta_p_mean_mc, Delta_p_prime_rms, Delta_p_prime_H_mean = calculate_statistics(qs, delPs, H_mean_type=H_mean_type)
        q_afn_val_mc = q_AFN(Delta_p_mean_mc)
        I_q = q_prime_rms / np.abs(q_afn_val_mc)
        I_p = Delta_p_prime_rms / (2 * np.abs(Delta_p_mean_mc))

        if QPressure:
            I = I_p
        else:
            I = I_q
        if HPressure:
            R = Delta_p_prime_H_mean / np.sqrt(np.abs(Delta_p_mean_mc))
            blended_func = pyafn.ventilationBlendedScaling_p
            H_bound = np.sqrt(2 * I)
            H_tangent = np.sqrt(3 * np.sqrt(3) / 8 * I)
        else:
            R = q_prime_H_mean / np.abs(q_afn_val_mc)
            blended_func = pyafn.ventilationBlendedScaling_q
            H_bound = I
            H_tangent = I
    
        I_values.append(I)
        H_values.append(R)
        I_q_values.append(I_q)
        I_p_values.append(I_p)
        H_bound_values.append(H_bound)
        H_tangent_values.append(H_tangent)
        q_afn_values.append(q_afn_val_mc)
    
        # Store Monte Carlo results
        mc_q_mean.append(q_mean_mc)
        mc_q_mean_normalized.append(q_mean_mc / q_afn_val_mc)
    
        # Calculate analytical predictions
        analytical_mean_dom.append(_scale_scalar(pyafn.ventilationUpperScaling, I))
        analytical_fluct_dom.append(_scale_scalar(pyafn.ventilationLowerScaling, R))
        analytical_fluct_dom_bound.append(_scale_scalar(pyafn.ventilationLowerScaling, H_bound))
        analytical_fluct_tan.append(_scale_scalar(pyafn.ventilationLowerScaling, H_tangent))
        analytical_blend.append(_scale_scalar(blended_func, I))

        if len(mc_q_mean) % 5 == 0:
            print(f"I_computed={I:.3f}, R={R:.3f}, "
                f"Δp_mean={Delta_p_mean_mc:.3f}, q̄/q_AFN (MC)={q_mean_mc/q_afn_val_mc:.4f}, "
                f"q̄/q_AFN (Blend)={analytical_blend[-1]:.4f}")

    I_values = np.array(I_values)
    H_values = np.array(H_values)
    I_q_values = np.array(I_q_values)
    I_p_values = np.array(I_p_values)
    H_bound_values = np.array(H_bound_values)
    H_tangent_values = np.array(H_tangent_values)
    q_afn_val_mc = np.array(q_afn_values)


    # Plot dimensional flow against inverse fluctuation intensity.
    if QPressure:
        x_star_label = r'$I^*(\Delta C_p)^{-1/2}$'
        x_label = r'$I(\Delta C_p)^{-1/2}$'
        exponent = -0.5
        title = r'Pressure-based; $\Delta C_p \sim \mathcal{N}(\overline{\Delta C_p}, \sigma_{\Delta C_p}^2)$'
    else:
        x_star_label = r'$I^*(q_n)^{-1}$'
        x_label = r'$I(q_n)^{-1}$'
        exponent = -1.0
        title = r'Ventilation-based; $q_n \sim \mathcal{N}(\overline{q}_n, \sigma_{q_n}^2)$'
    x_star = piecewise_transition_intensity(use_pressure=QPressure)**exponent
    x_vals = I_values**exponent
    # Nondimensionalize ventilation rates: q_n = q / (U_10 A).
    q_ref = U_10 * A
    y_mc = np.asarray(mc_q_mean) / q_ref
    q_mp_n = q_afn_val_mc / q_ref
    y_label = r'$\overline{q}_n$'

    # Draw the same nondimensional curves in both figures.
    for ax in (axes[0, i], axes_top[i]):
        ax.plot(x_vals, y_mc, 'kx', label='Monte Carlo', markersize=6, alpha=1)
        ax.plot(x_vals, q_mp_n, color='red', linestyle='--', label='$\\overline{q}_n = q_{MP,n}$', linewidth=1)
        ax.plot(x_vals, np.asarray(analytical_mean_dom)*q_mp_n, color='blue', linestyle='--', label='$\\overline{q}_n = q_{MP,n}\\sqrt{1-I^2}$', linewidth=2.5)
        ax.plot(x_vals, np.asarray(analytical_fluct_dom)*q_mp_n, color='green', linestyle='--', label='$\\overline{q}_n = q_{MP,n}/(2H)$', linewidth=2.5)
        ax.plot(x_vals, np.asarray(analytical_fluct_dom_bound)*q_mp_n, color='green', linestyle=':', label= '$\\overline{q}_n = q_{MP,n}/(2H_{\\mathrm{U}})$', linewidth=2.5)
        ax.plot(x_vals, np.asarray(analytical_blend)*q_mp_n, color='black', linestyle='-', label='$\\overline{q}_n = q_{\\mathrm{PW},n}$', linewidth=1.5)
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
        # ax.plot(x_vals, np.asarray(analytical_fluct_tan)*q_afn_val_mc, color='#D55E00', linestyle='-.', label='$\\overline{q} = q_{MP}(2H_{H,\\mathrm{T}})$', linewidth=2)
        # ax.plot(q_afn_values, analytical_blend, color='#009E73', linestyle='-', label='Blended model', linewidth=2)
        ax.set_xlabel(x_label, fontsize=14)
        ax.set_ylabel(y_label, fontsize=14)
        ax.set_title(title, fontsize=16, fontweight='normal')
        if i == 0:
            ax.legend(fontsize=11, loc='lower right')
        ax.grid(True, alpha=0.3)
        ax.set_ylim([0, 1.1 * max(np.max(y_mc), np.max(q_mp_n))])

    # # Plot 2: Error between Monte Carlo and analytical
    # ax = axes[i, 1]
    # error_mean_dom = np.array(mc_q_mean_normalized) - np.array(analytical_mean_dom)
    # error_fluct_tan = np.array(mc_q_mean_normalized) - np.array(analytical_fluct_tan)
    # error_blend = np.array(mc_q_mean_normalized) - np.array(analytical_blend)
    # ax.plot(x_vals, error_mean_dom, 'b-', label='Mean-flow model error', linewidth=2)
    # ax.plot(x_vals, error_fluct_tan, 'r-', label='Fluctuation tangent error', linewidth=2)
    # ax.plot(x_vals, error_blend, 'g-', label='Blended model error', linewidth=2)
    # ax.axhline(y=0, color='black', linestyle='-', linewidth=0.5)
    # ax.axvline(x=q_std, color='gray', linestyle=':', linewidth=1.5)
    # ax.set_xlabel(x_label, fontsize=14)
    # ax.set_ylabel('Error in $\\overline{q}$', fontsize=14)
    # ax.set_title('Model Error vs Monte Carlo', fontsize=13, fontweight='bold')
    # ax.legend(fontsize=10)
    # ax.grid(True, alpha=0.3)
    # ax.set_ylim([-0.6, 0.6])

    # Plot 3: Intensity values
    ax = axes[1, i]
    ax.plot(x_vals, 1/I_p_values, color='#0072B2', linestyle='-', label='$I(\\Delta C_p)^{-1}$', linewidth=2)
    ax.plot(x_vals, 1/I_q_values, color='#D55E00', linestyle='-', label='$I(q_n)^{-1}$', linewidth=2)
    ax.set_xlabel(x_label, fontsize=14)
    ax.set_ylabel('$I^{-1}$', fontsize=14)
    # ax.set_title('I vs q_AFN', fontsize=13, fontweight='bold')
    if i == 0:
        ax.legend(fontsize=11, loc='lower right')
    ax.grid(True, alpha=0.3)

    # Plot 4: Fluctuation residence values
    ax = axes[2, i]
    ax.plot(x_vals, 1/H_values, color='#D55E00', linestyle='-', label='$H^{-1}$', linewidth=2)
    ax.plot(x_vals, 1/H_bound_values, color='#0072B2', linestyle=':', label='$H_{\\mathrm{U}}^{-1}$', linewidth=2)
    ax.plot(x_vals, 1/H_tangent_values, color='#009E73', linestyle='--', label='$H_{\\mathrm{T}}^{-1}$', linewidth=2)
    ax.set_xlabel(x_label, fontsize=14)
    ax.set_ylabel('$H^{-1}$', fontsize=14)
    # ax.set_title('R values vs q_AFN', fontsize=13, fontweight='bold')
    if i == 0:
        ax.legend(fontsize=11, loc='lower right')
    ax.grid(True, alpha=0.3)
    ax.set_ylim(bottom=0)

    # # Print summary statistics
    # print("\n" + "="*60)
    # print("SUMMARY STATISTICS")
    # print("="*60)
    # valid_regime = I_values < 1.0
    # max_error_blend = np.max(np.abs(error_blend[valid_regime]))
    # mean_error_blend = np.mean(np.abs(error_blend[valid_regime]))
    # print(f"Blended model (I < 1.0):")
    # print(f"  Max absolute error: {max_error_blend:.6f}")
    # print(f"  Mean absolute error: {mean_error_blend:.6f}")

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
