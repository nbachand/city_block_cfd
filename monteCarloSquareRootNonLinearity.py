import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# Constants
C_d = 0.611  # Discharge coefficient
A = 10      # Area (m^2)
rho = 1.2    # Air density (kg/m^3)
FhPressure = True  # Set to True to use pressure-based Fh definition
FqPressure = False  # Set to True to use pressure-based Fq definition
randomPressure = True  # Set to True to sample pressure, False to sample flow
Fh_mean_type='harmonic'  # 'harmonic', 'geometric', 'arithmetic', or 'quadratic' mean for Fh calculation

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

def calculate_statistics(q_samples, Delta_p_samples, Fh_mean_type='harmonic'):
    # Calculate statistics
    q_mean = np.mean(q_samples)
    q_prime = q_samples - q_mean
    q_prime_rms = np.sqrt(np.mean(q_prime**2))
    q_prime_Fh = np.abs(q_prime)

    Delta_p_mean = np.mean(Delta_p_samples)
    Delta_p_prime = Delta_p_samples - Delta_p_mean
    Delta_p_prime_rms = np.sqrt(np.mean(Delta_p_prime**2))
    Delta_p_prime_Fh = np.sqrt(np.abs(Delta_p_prime))

    if Fh_mean_type == 'harmonic':
        q_prime_Fh_mean = harmonic_mean(q_prime_Fh)  # Harmonic mean of |q'|
        Delta_p_prime_Fh_mean = harmonic_mean(Delta_p_prime_Fh)  # Harmonic mean of sqrt(|Δp'|)^-1
    elif Fh_mean_type == 'geometric':
        q_prime_Fh_mean = geometric_mean(q_prime_Fh)  # Geometric mean of |q'|
        Delta_p_prime_Fh_mean = geometric_mean(Delta_p_prime_Fh)  # Geometric mean of sqrt(|Δp'|)^-1
    elif Fh_mean_type == 'arithmetic':
        q_prime_Fh_mean = np.mean(q_prime_Fh)  # Arithmetic mean of |q'|
        Delta_p_prime_Fh_mean = np.mean(Delta_p_prime_Fh)  # Arithmetic mean of sqrt(|Δp'|)^-1
    elif Fh_mean_type == 'quadratic':
        q_prime_Fh_mean = np.sqrt(np.mean(q_prime_Fh**2))  # Quadratic mean of |q'|
        Delta_p_prime_Fh_mean = np.sqrt(np.mean(Delta_p_prime_Fh**2))  # Quadratic mean of sqrt(|Δp'|)^-1
    
    return q_mean, q_prime_rms, q_prime_Fh_mean, Delta_p_mean, Delta_p_prime_rms, Delta_p_prime_Fh_mean
    

def analytical_mean_flow_dominated(q_afn, Fq):
    """
    Analytical solution from Eq. (qAFN_qstd) - mean flow dominated
    q̄ = q_AFN * sqrt(1 - Fq^2)
    """
    if Fq >= 1.0:
        return 0.0
    return q_afn * np.sqrt(1 - Fq**2)

def analytical_fluctuation_dominated(q_afn, Fh):
    """
    Analytical solution from Eq. (q_linear_deltap) - fluctuation dominated
    q̄ = q_AFN / (2*Fh)
    """
    return q_afn / (2 * Fh)

def gamma_blend_poly(x, blend_bound=1):
    if x <= blend_bound:
        return 3*(x/blend_bound)**4 - 2*(x/blend_bound)**6  # Smooth blending function that transitions from 0 to 1 as x goes from 0 to 1
    else:
        return 1.0
    
def analytical_blended(q_afn, Fh, Fq, blend_bound=1):
    """
    Blended analytical solution from Eq. (blended_model_q)
    q̄ = q_AFN * ([1-γ(Fq)]*sqrt(1-Fq^2) + γ(Fq)/(2*Fh))
    """
    
    if Fq >= 1.0:
        # Pure fluctuation-dominated regime
        term1 = 0
    else:
        term1 = analytical_mean_flow_dominated(q_afn, Fq)
    term2 = analytical_fluctuation_dominated(q_afn, Fh)

    gamma = gamma_blend_poly(Fq, blend_bound)
    
    return ((1-gamma)*term1 + gamma*term2)

# Simulation parameters
Delta_p_mean = 10.0  # Mean pressure difference (Pa)
q_afn_val = q_AFN(Delta_p_mean)
Fq_gen_values = np.linspace(0.01, 4, 40)  # Range of Fq = sqrt(<q'^2>) / q_AFN

# Storage for results
mc_q_mean = []
mc_q_mean_normalized = []
analytical_mean_dom = []
analytical_fluct_dom = []
analytical_fluct_dom_bound = []
analytical_blend = []
analytical_blend_bound = []
analytical_AFN = []

print("Running Monte Carlo simulations...")
print(f"Mean pressure: {Delta_p_mean} Pa")
print(f"q_AFN: {q_afn_val:.4f} m³/s\n")

Fh_values = []
Fq_values = []
for Fq_gen in Fq_gen_values:

    if randomPressure:
        # From Fq definition and linearization: Fq ≈ (1/2) * sqrt(<Δp'^2>) / |Δp_mean|
        # So: sqrt(<Δp'^2>) ≈ 2 * Fq * |Δp_mean|
        Delta_p_std = 2 * Fq_gen * np.abs(Delta_p_mean)
        
        # Monte Carlo simulation
        qs, delPs = monte_carlo_average_pressure(
            Delta_p_mean, Delta_p_std, n_samples=100000
        )
    else:
        # From Fq definition and linearization: Fq ≈ sqrt(<q'^2>) / q_AFN
        # So: sqrt(<q'^2>) ≈ Fq * q_AFN
        q_std = Fq_gen * q_afn_val
        
        # Monte Carlo simulation
        qs, delPs = monte_carlo_average_flow(
            q_afn_val, q_std, n_samples=100000
        )

    # plt.figure()
    # plt.hist(qs, bins=50, alpha=0.1, label='q')
    # plt.hist(delPs, bins=50, alpha=0.1, label='P')
    # plt.title(f"Fq_gen={Fq_gen:.3f}", fontsize=12)
    # plt.legend()
    # plt.show()

    q_mean_mc, q_prime_rms, q_prime_Fh_mean, Delta_p_mean_mc, Delta_p_prime_rms, Delta_p_prime_Fh_mean = calculate_statistics(qs, delPs, Fh_mean_type=Fh_mean_type)
    
    q_afn_val_mc = q_AFN(Delta_p_mean_mc)

    if FqPressure:
        Fq = Delta_p_prime_rms / (2 * np.abs(Delta_p_mean_mc))
    else:
        Fq = q_prime_rms / np.abs(q_afn_val_mc)
    if FhPressure:
        Fh = Delta_p_prime_Fh_mean / np.sqrt(Delta_p_mean_mc)
        Fh_bound = np.sqrt(2 * Fq)
        blend_bound = 0.93
    else:
        Fh = q_prime_Fh_mean / np.abs(q_afn_val_mc)
        Fh_bound = Fq
        blend_bound = 1/np.sqrt(2)

    Fq_values.append(Fq)
    Fh_values.append(Fh)
    
    # Store Monte Carlo results
    mc_q_mean.append(q_mean_mc)
    mc_q_mean_normalized.append(q_mean_mc / q_afn_val_mc)
    
    # Calculate analytical predictions
    analytical_mean_dom.append(analytical_mean_flow_dominated(q_afn_val_mc, Fq) / q_afn_val_mc)
    analytical_fluct_dom.append(analytical_fluctuation_dominated(q_afn_val_mc, Fh) / q_afn_val_mc)
    analytical_fluct_dom_bound.append(analytical_fluctuation_dominated(q_afn_val_mc, Fh_bound) / q_afn_val_mc)
    analytical_blend.append(analytical_blended(q_afn_val_mc, Fh, Fq, blend_bound) / q_afn_val_mc)
    analytical_blend_bound.append(analytical_blended(q_afn_val_mc, Fh_bound, Fq, blend_bound) / q_afn_val_mc)
    if len(mc_q_mean) % 5 == 0:
        print(f"Fq_gen={Fq_gen:.3f}, Fq_computed={Fq:.3f}, Fh={Fh:.3f}, "
              f"Δp_mean={Delta_p_mean_mc:.3f}, q̄/q_AFN (MC)={q_mean_mc/q_afn_val_mc:.4f}, "
              f"q̄/q_AFN (Blend)={analytical_blend[-1]:.4f}")

# plt.figure()
# plt.plot(Fq_gen_values, Fq_values, 'o-')

# plt.figure()
# plt.plot(Fq_values, Fh_values, 'o-')
# plt.ylim([0, 5])
# plt.show()

# plt.figure()
# plt.plot(Fq_gen_values, Fq_values, 'o-')
# plt.show()

# Plotting
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# Plot 1: Normalized mean flow vs Fq
ax = axes[0, 0]
ax.plot(Fq_values, mc_q_mean_normalized, 'ko', label='Monte Carlo', markersize=6, alpha=0.6)
ax.plot(Fq_values, analytical_mean_dom, 'b-', label='Mean-flow dominated\n$\\bar{q} = q_{AFN}\\sqrt{1-F_2^2}$', linewidth=2)
ax.plot(Fq_values, analytical_fluct_dom, 'r--', label='Fluctuation dominated\n$\\bar{q} = (1/2)q_{AFN}F_1$', linewidth=2)
ax.plot(Fq_values, analytical_fluct_dom_bound, 'r:', label='Fluctuation dominated lower bound', linewidth=2)
ax.plot(Fq_values, analytical_blend, 'g-', label='Blended model', linewidth=2.5)
ax.plot(Fq_values, analytical_blend_bound, 'g--', label='Blended model bound', linewidth=2.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5, label='$F_2=1$ (validity limit)')
ax.axvline(x=blend_bound, color='lightgray', linestyle=':', linewidth=1.5, label='blend bound')
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
ax.plot(Fq_values, error_mean_dom, 'b-', label='Mean-flow model error', linewidth=2)
ax.plot(Fq_values, error_blend, 'g-', label='Blended model error', linewidth=2)
ax.axhline(y=0, color='black', linestyle='-', linewidth=0.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.set_xlabel('$F_2 = \\sqrt{\\overline{(q\')^2}}/q_{AFN}$', fontsize=12)
ax.set_ylabel('Error in $\\bar{q}/q_{AFN}$', fontsize=12)
ax.set_title('Model Error vs Monte Carlo', fontsize=13, fontweight='bold')
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3)

# Plot 3: Absolute error (log scale)
ax = axes[1, 0]
ax.semilogy(Fq_values, np.abs(error_mean_dom), 'b-', label='Mean-flow model', linewidth=2)
ax.semilogy(Fq_values, np.abs(error_blend), 'g-', label='Blended model', linewidth=2)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.set_xlabel('$F_2 = \\sqrt{\\overline{(q\')^2}}/q_{AFN}$', fontsize=12)
ax.set_ylabel('Absolute Error (log scale)', fontsize=12)
ax.set_title('Absolute Model Error', fontsize=13, fontweight='bold')
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3, which='both')

# Plot 4: Blending function γ(Fq)
ax = axes[1, 1]
gamma_values = [gamma_blend_poly(Fq, blend_bound=blend_bound) for Fq in Fq_values]
ax.plot(Fq_values, gamma_values, 'purple', linewidth=2.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.axvline(x=blend_bound, color='lightgray', linestyle=':', linewidth=1.5, label='blend bound')

ax.set_xlabel('$F_2 = \\sqrt{\\overline{(q\')^2}}/q_{AFN}$', fontsize=12)
ax.set_ylabel('$\\gamma(F_2)$', fontsize=12)
ax.set_title('Blending Function (OVL-based)', fontsize=13, fontweight='bold')
ax.grid(True, alpha=0.3)
ax.set_ylim([0, 1])

plt.tight_layout()
plt.show()

# # Print summary statistics
# print("\n" + "="*60)
# print("SUMMARY STATISTICS")
# print("="*60)
# valid_regime = Fq_values < 1.0
# max_error_blend = np.max(np.abs(error_blend[valid_regime]))
# mean_error_blend = np.mean(np.abs(error_blend[valid_regime]))
# print(f"Blended model (Fq < 1.0):")
# print(f"  Max absolute error: {max_error_blend:.6f}")
# print(f"  Mean absolute error: {mean_error_blend:.6f}")