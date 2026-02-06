import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# Constants
C_d = 0.611  # Discharge coefficient
A = 10      # Area (m^2)
rho = 1.2    # Air density (kg/m^3)
F1Pressure = True  # Set to True to use pressure-based F1 definition
F2Pressure = False  # Set to True to use pressure-based F2 definition
randomPressure = False  # Set to True to sample pressure, False to sample flow
F1_mean_type='geometric'  # 'harmonic', 'geometric', or 'arithmetic' mean for F1 calculation

def q_AFN(Delta_p_mean):
    """Airflow network prediction"""
    return C_d * A * np.sqrt(2 * np.abs(Delta_p_mean) / rho)

def q_instantaneous(Delta_p):
    """Instantaneous flow from orifice equation"""
    return np.sign(Delta_p) * C_d * A * np.sqrt(2 * np.abs(Delta_p) / rho)

def p_instantaneous(q):
    """Instantaneous pressure from flow"""
    return np.sign(q) * (q / (C_d * A))**2 * (rho / 2)

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
    q_samples = q_instantaneous(Delta_p_samples)
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

def calculate_statistics(q_samples, Delta_p_samples, F1_mean_type='harmonic'):
    # Calculate statistics
    q_mean = np.mean(q_samples)
    q_prime = q_samples - q_mean
    q_prime_rms = np.sqrt(np.mean(q_prime**2))
    q_prime_F1 = np.abs(q_prime)

    Delta_p_mean = np.mean(Delta_p_samples)
    Delta_p_prime = Delta_p_samples - Delta_p_mean
    Delta_p_prime_rms = np.sqrt(np.mean(Delta_p_prime**2))
    Delta_p_prime_F1 = np.sqrt(np.abs(Delta_p_prime))

    if F1_mean_type == 'harmonic':
        q_prime_F1_mean = harmonic_mean(q_prime_F1)  # Harmonic mean of |q'|
        Delta_p_prime_F1_mean = harmonic_mean(Delta_p_prime_F1)  # Harmonic mean of sqrt(|Δp'|)^-1
    elif F1_mean_type == 'geometric':
        q_prime_F1_mean = geometric_mean(q_prime_F1)  # Geometric mean of |q'|
        Delta_p_prime_F1_mean = geometric_mean(Delta_p_prime_F1)  # Geometric mean of sqrt(|Δp'|)^-1
    elif F1_mean_type == 'arithmetic':
        q_prime_F1_mean = np.mean(q_prime_F1)  # Arithmetic mean of |q'|
        Delta_p_prime_F1_mean = np.mean(Delta_p_prime_F1)  # Arithmetic mean of sqrt(|Δp'|)^-1
    
    return q_mean, q_prime_rms, q_prime_F1_mean, Delta_p_mean, Delta_p_prime_rms, Delta_p_prime_F1_mean
    

def analytical_mean_flow_dominated(q_afn, F2):
    """
    Analytical solution from Eq. (qAFN_qstd) - mean flow dominated
    q̄ = q_AFN * sqrt(1 - F2^2)
    """
    if F2 >= 1.0:
        return 0.0
    return q_afn * np.sqrt(1 - F2**2)

def analytical_fluctuation_dominated(q_afn, F1):
    """
    Analytical solution from Eq. (q_linear_deltap) - fluctuation dominated
    q̄ = q_AFN / (2*F1)
    """
    return q_afn / (2 * F1)

def gamma_blend(x):
    if x <= 1:
        return 3*x**4 - 2*x**6  # Smooth blending function that transitions from 0 to 1 as x goes from 0 to 1
    else:
        return 1.0
    
    # # --- First Expression ---
    # # Active for -0.25 <= x <= 0.25
    # radicand1 = -4*x**2 + 1
    # if radicand1 <= 0:
    #     radicand1 = 0

    # # --- Second Expression ---
    # # Active for 0.75 <= x <= 1.25
    # radicand2 = -4*(x - 1)**2 + 1
    # if radicand2 <= 0:
    #     radicand2 = 0

    # # Since the active domains do not overlap, one of val1 or val2 will always be 0.
    # return (1 - np.sqrt(radicand1) + np.sqrt(radicand2)) / 2
    
def analytical_blended(q_afn, F1, F2):
    """
    Blended analytical solution from Eq. (blended_model_q)
    q̄ = q_AFN * ([1-γ(F2)]*sqrt(1-F2^2) + γ(F2)/(2*F1))
    """
    
    if F2 >= 1.0:
        # Pure fluctuation-dominated regime
        term1 = 0
    else:
        term1 = analytical_mean_flow_dominated(q_afn, F2)
    term2 = analytical_fluctuation_dominated(q_afn, F1)

    gamma = gamma_blend(F2)
    
    return ((1-gamma)*term1 + gamma*term2)

# Simulation parameters
Delta_p_mean = 10.0  # Mean pressure difference (Pa)
F2_gen_values = np.linspace(0.01, 4, 40)  # Range of F2 = sqrt(<q'^2>) / q_AFN

# Storage for results
mc_q_mean = []
mc_q_mean_normalized = []
analytical_mean_dom = []
analytical_fluct_dom = []
analytical_blend = []
analytical_AFN = []

print("Running Monte Carlo simulations...")
print(f"Mean pressure: {Delta_p_mean} Pa")
print(f"q_AFN: {q_AFN(Delta_p_mean):.4f} m³/s\n")

F1_values = []
F2_values = []
for F2_gen in F2_gen_values:

    if randomPressure:
        # From F2 definition and linearization: F2 ≈ (1/2) * sqrt(<Δp'^2>) / |Δp_mean|
        # So: sqrt(<Δp'^2>) ≈ 2 * F2 * |Δp_mean|
        Delta_p_std = 2 * F2_gen * np.abs(Delta_p_mean)
        
        # Monte Carlo simulation
        qs, delPs = monte_carlo_average_pressure(
            Delta_p_mean, Delta_p_std, n_samples=100000
        )
    else:
        # Calculate q_AFN
        q_afn_val = q_AFN(Delta_p_mean)
        # From F2 definition and linearization: F2 ≈ sqrt(<q'^2>) / q_AFN
        # So: sqrt(<q'^2>) ≈ F2 * q_AFN
        q_std = F2_gen * q_afn_val
        
        # Monte Carlo simulation
        qs, delPs = monte_carlo_average_flow(
            q_afn_val, q_std, n_samples=100000
        )

    # plt.figure()
    # plt.hist(qs, bins=50, alpha=0.1, label='q')
    # plt.hist(delPs, bins=50, alpha=0.1, label='P')
    # plt.title(f"F2_gen={F2_gen:.3f}", fontsize=12)
    # plt.legend()
    # plt.show()

    q_mean_mc, q_prime_rms, q_prime_F1_mean, Delta_p_mean_mc, Delta_p_prime_rms, Delta_p_prime_F1_mean = calculate_statistics(qs, delPs, F1_mean_type=F1_mean_type)
    
    q_afn_val_mc = q_AFN(Delta_p_mean_mc)

    if F1Pressure:
        F1 = Delta_p_prime_F1_mean / np.sqrt(Delta_p_mean_mc)
    else:
        F1 = q_prime_F1_mean / np.abs(q_afn_val_mc)
    if F2Pressure:
        F2 = Delta_p_prime_rms / (2 * np.abs(Delta_p_mean_mc))
    else:
        F2 = q_prime_rms / np.abs(q_afn_val_mc)

    F2_values.append(F2)
    F1_values.append(F1)
    
    # Store Monte Carlo results
    mc_q_mean.append(q_mean_mc)
    mc_q_mean_normalized.append(q_mean_mc / q_afn_val_mc)
    
    # Calculate analytical predictions
    analytical_mean_dom.append(analytical_mean_flow_dominated(q_afn_val_mc, F2) / q_afn_val_mc)
    analytical_fluct_dom.append(analytical_fluctuation_dominated(q_afn_val_mc, F1) / q_afn_val_mc)
    analytical_blend.append(analytical_blended(q_afn_val_mc, F1, F2) / q_afn_val_mc)
    
    if len(mc_q_mean) % 5 == 0:
        print(f"F2_gen={F2_gen:.3f}, F2_computed={F2:.3f}, F1={F1:.3f}, "
              f"Δp_mean={Delta_p_mean_mc:.3f}, q̄/q_AFN (MC)={q_mean_mc/q_afn_val_mc:.4f}, "
              f"q̄/q_AFN (Blend)={analytical_blend[-1]:.4f}")

# plt.figure()
# plt.plot(F2_gen_values, F2_values, 'o-')

plt.figure()
plt.plot(F2_values, F1_values, 'o-')
plt.ylim([0, 5])
plt.show()

plt.figure()
plt.plot(F2_gen_values, F2_values, 'o-')
plt.show()

# Plotting
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# Plot 1: Normalized mean flow vs F2
ax = axes[0, 0]
ax.plot(F2_values, mc_q_mean_normalized, 'ko', label='Monte Carlo', markersize=6, alpha=0.6)
ax.plot(F2_values, analytical_mean_dom, 'b-', label='Mean-flow dominated\n$\\bar{q} = q_{AFN}\\sqrt{1-F_2^2}$', linewidth=2)
ax.plot(F2_values, analytical_fluct_dom, 'r--', label='Fluctuation dominated\n$\\bar{q} = (1/2)q_{AFN}F_1$', linewidth=2)
ax.plot(F2_values, analytical_blend, 'g-', label='Blended model', linewidth=2.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5, label='$F_2=1$ (validity limit)')
ax.set_xlabel('$F_2 = \\sqrt{\\overline{(q\')^2}}/q_{AFN}$', fontsize=12)
ax.set_ylabel('$\\bar{q}/q_{AFN}$', fontsize=12)
ax.set_title('Normalized Mean Flow vs Fluctuation Ratio', fontsize=13, fontweight='bold')
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3)
ax.set_ylim([0, 1.5])

# Plot 2: Error between Monte Carlo and analytical
ax = axes[0, 1]
error_mean_dom = np.array(mc_q_mean_normalized) - np.array(analytical_mean_dom)
error_blend = np.array(mc_q_mean_normalized) - np.array(analytical_blend)
ax.plot(F2_values, error_mean_dom, 'b-', label='Mean-flow model error', linewidth=2)
ax.plot(F2_values, error_blend, 'g-', label='Blended model error', linewidth=2)
ax.axhline(y=0, color='black', linestyle='-', linewidth=0.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.set_xlabel('$F_2 = \\sqrt{\\overline{(q\')^2}}/q_{AFN}$', fontsize=12)
ax.set_ylabel('Error in $\\bar{q}/q_{AFN}$', fontsize=12)
ax.set_title('Model Error vs Monte Carlo', fontsize=13, fontweight='bold')
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3)

# Plot 3: Absolute error (log scale)
ax = axes[1, 0]
ax.semilogy(F2_values, np.abs(error_mean_dom), 'b-', label='Mean-flow model', linewidth=2)
ax.semilogy(F2_values, np.abs(error_blend), 'g-', label='Blended model', linewidth=2)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.set_xlabel('$F_2 = \\sqrt{\\overline{(q\')^2}}/q_{AFN}$', fontsize=12)
ax.set_ylabel('Absolute Error (log scale)', fontsize=12)
ax.set_title('Absolute Model Error', fontsize=13, fontweight='bold')
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3, which='both')

# Plot 4: Blending function γ(F2)
ax = axes[1, 1]
gamma_values = [gamma_blend(f2) for f2 in F2_values]
ax.plot(F2_values, gamma_values, 'purple', linewidth=2.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.set_xlabel('$F_2 = \\sqrt{\\overline{(q\')^2}}/q_{AFN}$', fontsize=12)
ax.set_ylabel('$\\gamma(F_2)$', fontsize=12)
ax.set_title('Blending Function (OVL-based)', fontsize=13, fontweight='bold')
ax.grid(True, alpha=0.3)
ax.set_ylim([0, 1])

plt.tight_layout()
plt.savefig('flow_model_validation.png', dpi=300, bbox_inches='tight')
plt.show()

# # Print summary statistics
# print("\n" + "="*60)
# print("SUMMARY STATISTICS")
# print("="*60)
# valid_regime = F2_values < 1.0
# max_error_blend = np.max(np.abs(error_blend[valid_regime]))
# mean_error_blend = np.mean(np.abs(error_blend[valid_regime]))
# print(f"Blended model (F2 < 1.0):")
# print(f"  Max absolute error: {max_error_blend:.6f}")
# print(f"  Mean absolute error: {mean_error_blend:.6f}")