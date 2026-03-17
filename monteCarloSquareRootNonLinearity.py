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
H_mean_type='harmonic'  # 'harmonic', 'geometric', 'arithmetic', or 'quadratic' mean for H calculation

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
    
fig, axes = plt.subplots(3, 2, figsize=(10, 8), sharex=True, gridspec_kw={'height_ratios': [2, 1, 1]})
for i, usePressure in enumerate([False, True]):
    HPressure = usePressure  # Set to True ts use pressure-based H definition
    QPressure = usePressure  # Set to True to use pressure-based Q definition
    randomPressure = usePressure  # Set to True to sample pressure, False to sample flow

    # Simulation parameters
    q_std = 1.0  # Base standard deviation for generating I values
    max_q = 3.0

    if randomPressure:
        max_value = p_instantaneous(max_q)  # Convert max flow to max pressure for sampling
        min_value = p_instantaneous(0.1)  # Convert min flow to min pressure for sampling
        base_std = 2 * p_instantaneous(q_std)  # Set base std to the pressure corresponding to q_AFN=1
    else:
        max_value = max_q  # Maximum flow for sampling
        min_value = 0.01  # Minimum flow for sampling
        base_std = q_std  # Set base std to the flow corresponding to q_AFN=1
    means = np.logspace(np.log10(min_value), np.log10(max_value), 40)

    # Storage for results
    mc_q_mean = []
    mc_q_mean_normalized = []
    analytical_mean_dom = []
    analytical_fluct_dom = []
    analytical_fluct_dom_bound = []
    analytical_fluct_tan = []
    analytical_blend = []
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
                mean, base_std, n_samples=1000000
            )
        else:
            # Monte Carlo simulation
            qs, delPs = monte_carlo_average_flow(
                mean, base_std, n_samples=1000000
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


    # Plotting
    if QPressure:
        x_vals = 1 / np.sqrt(I_values)  # Pressure-based intensity scales as q_AFN^2
        x_label = '$I(p)^{-0.5}$'
        title = 'Pressure-based; $p \\sim \\mathcal{N}(\\overline{p}, \\sigma_p^2)$'
    else:
        title = 'Flow-based; $q \\sim \\mathcal{N}(\\overline{q}, \\sigma_q^2)$'
        x_vals = 1 / I_values
        x_label = '$I(q)^{-1}$'
    
    # Plot 1: Mean flow vs transformed intensity
    ax = axes[0, i]
    ax.plot(x_vals, mc_q_mean_normalized*q_afn_val_mc, 'kx', label='Monte Carlo', markersize=6, alpha=1)
    ax.plot(x_vals, x_vals, color='gray', linestyle='--', label='$\\overline{q} = q_{PS}$', linewidth=1)
    ax.plot(x_vals, analytical_mean_dom*q_afn_val_mc, color='#0072B2', linestyle='-', label='$\\overline{q} = q_{PS}\\sqrt{1-I^2}$', linewidth=1.5)
    ax.plot(x_vals, analytical_fluct_dom*q_afn_val_mc, color='#D55E00', linestyle='-', label='$\\overline{q} = q_{PS}/(2R)$', linewidth=1.5)
    ax.plot(x_vals, analytical_fluct_dom_bound*q_afn_val_mc, color='#D55E00', linestyle=':', label= '$\\overline{q} = q_{PS}/(2H_{\\mathrm{U}})$', linewidth=2)
    # ax.plot(x_vals, analytical_fluct_tan*q_afn_val_mc, color='#D55E00', linestyle='-.', label='$\\overline{q} = q_{PS}(2H_{H,\\mathrm{T}})$', linewidth=2)
    # ax.plot(q_afn_values, analytical_blend, color='#009E73', linestyle='-', label='Blended model', linewidth=2)
    ax.plot(x_vals, analytical_blend*q_afn_val_mc, color='#009E73', linestyle='--', label='$\\overline{q} = q_{\\mathrm{PW}}$', linewidth=2)
    ax.set_xlabel(x_label, fontsize=14)
    ax.set_ylabel('$\\overline{q}$', fontsize=14)
    ax.set_title(title, fontsize=16, fontweight='normal')
    if i == 0:
        ax.legend(fontsize=11, loc='lower right')
    ax.grid(True, alpha=0.3)
    ax.set_ylim([0, 1.1*max_q])

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
    ax.plot(x_vals, 1/I_p_values, color='#0072B2', linestyle='-', label='$I(p)^{-1}$', linewidth=2)
    ax.plot(x_vals, 1/I_q_values, color='#D55E00', linestyle='-', label='$I(q)^{-1}$', linewidth=2)
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
    ax.set_ylim([0, 1.1*max_q])

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

plt.tight_layout()
plt.show()

plt.savefig('monte_carlo_square_root_non_linearity.png', dpi=300)