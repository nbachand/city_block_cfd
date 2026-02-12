import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# Constants
C_d = 0.611  # Discharge coefficient
A = 10      # Area (m^2)
rho = 1.2    # Air density (kg/m^3)
HPressure = False  # Set to True to use pressure-based H definition
QPressure = False  # Set to True to use pressure-based Q definition
randomPressure = False  # Set to True to sample pressure, False to sample flow
H_mean_type='harmonic'  # 'harmonic', 'geometric', 'arithmetic', or 'quadratic' mean for H calculation

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
    

def analytical_mean_flow_dominated(q_afn, Rq):
    if Rq < 1.0:
        return 0.0
    return q_afn * np.sqrt(1 - 1/Rq**2)

def analytical_fluctuation_dominated(q_afn, Rh):
    return q_afn * Rh / 2

def gamma_blend_poly(x, blend_bound=1):
    if x >= blend_bound:
        return (3*(x*blend_bound)**-4 - 2*(x*blend_bound)**-6)  # Smooth blending function that transitions from 0 to 1 as x goes from 0 to 1
    else:
        return 1.0
    
def gamma_cutoff(x, blend_bound=1):
    return 1.0 if x >= blend_bound else 0.0
    
def analytical_blended(q_afn, Rh, Rq, blend_bound=1, f_blend = gamma_blend_poly):
    term1 = analytical_fluctuation_dominated(q_afn, Rh)
    term2 = analytical_mean_flow_dominated(q_afn, Rq)

    gamma = f_blend(Rq, blend_bound)
    
    return ((1-gamma)*term1 + gamma*term2)

# Simulation parameters
Delta_p_mean = 10.0  # Mean pressure difference (Pa)
q_afn_val = q_AFN(Delta_p_mean)
Rq_gen_values = np.logspace(-2, np.log10(6), 40)  # Range of Rq = sqrt(<q'^2>) / q_AFN

# Storage for results
mc_q_mean = []
mc_q_mean_normalized = []
analytical_mean_dom = []
analytical_fluct_dom = []
analytical_fluct_dom_bound = []
analytical_fluct_tan = []
analytical_blend = []
analytical_blend_tan = []
analytical_AFN = []

print("Running Monte Carlo simulations...")
print(f"Mean pressure: {Delta_p_mean} Pa")
print(f"q_AFN: {q_afn_val:.4f} m³/s\n")

Rh_values = []
Rq_values = []
Rq_q_values = []
for Rq_gen in Rq_gen_values:

    if randomPressure:
        Delta_p_std = 2 * np.abs(Delta_p_mean) / Rq_gen
        
        # Monte Carlo simulation
        qs, delPs = monte_carlo_average_pressure(
            Delta_p_mean, Delta_p_std, n_samples=100000
        )
    else:
        q_std = q_afn_val / Rq_gen
        
        # Monte Carlo simulation
        qs, delPs = monte_carlo_average_flow(
            q_afn_val, q_std, n_samples=100000
        )

    # plt.figure()
    # plt.hist(qs, bins=50, alpha=0.1, label='q')
    # plt.hist(delPs, bins=50, alpha=0.1, label='P')
    # plt.title(f"Rq_gen={Rq_gen:.3f}", fontsize=12)
    # plt.legend()
    # plt.show()

    q_mean_mc, q_prime_rms, q_prime_H_mean, Delta_p_mean_mc, Delta_p_prime_rms, Delta_p_prime_H_mean = calculate_statistics(qs, delPs, H_mean_type=H_mean_type)
    q_afn_val_mc = q_AFN(Delta_p_mean_mc)
    Rq_q =  np.abs(q_afn_val_mc) / q_prime_rms

    if QPressure:
        Rq = 2 * np.abs(Delta_p_mean_mc) / Delta_p_prime_rms 
    else:
        Rq = Rq_q
    if HPressure:
        Rh = np.sqrt(Delta_p_mean_mc) / Delta_p_prime_H_mean
        Rh_bound = np.sqrt(Rq / 2)
        blend_bound = 0.93
        tangent_scale = np.sqrt(16 / (3*np.sqrt(3)))
        tangent_bound = np.sqrt(3)
    else:
        Rh = np.abs(q_afn_val_mc) / q_prime_H_mean
        Rh_bound = Rq
        blend_bound = np.sqrt(2)
        tangent_scale = 1
        tangent_bound = blend_bound

    Rq_values.append(Rq)
    Rh_values.append(Rh)
    Rq_q_values.append(Rq_q)
    
    # Store Monte Carlo results
    mc_q_mean.append(q_mean_mc)
    mc_q_mean_normalized.append(q_mean_mc / q_afn_val_mc)
    
    # Calculate analytical predictions
    analytical_mean_dom.append(analytical_mean_flow_dominated(q_afn_val_mc, Rq) / q_afn_val_mc)
    analytical_fluct_dom.append(analytical_fluctuation_dominated(q_afn_val_mc, Rh) / q_afn_val_mc)
    analytical_fluct_dom_bound.append(analytical_fluctuation_dominated(q_afn_val_mc, Rh_bound) / q_afn_val_mc)
    analytical_fluct_tan.append(analytical_fluctuation_dominated(q_afn_val_mc, Rh_bound*tangent_scale) / q_afn_val_mc)
    analytical_blend.append(analytical_blended(q_afn_val_mc, Rh, Rq, blend_bound, f_blend=gamma_cutoff) / q_afn_val_mc)
    analytical_blend_tan.append(analytical_blended(q_afn_val_mc, 
                                                   Rh_bound*tangent_scale, 
                                                   Rq, tangent_bound, 
                                                   f_blend=gamma_cutoff
                                                   ) / q_afn_val_mc)
    if len(mc_q_mean) % 5 == 0:
        print(f"Rq_gen={Rq_gen:.3f}, Rq_computed={Rq:.3f}, Rh={Rh:.3f}, "
              f"Δp_mean={Delta_p_mean_mc:.3f}, q̄/q_AFN (MC)={q_mean_mc/q_afn_val_mc:.4f}, "
              f"q̄/q_AFN (Blend)={analytical_blend[-1]:.4f}")

Rq_values = np.array(Rq_values)
Rh_values = np.array(Rh_values)
Rq_q_values = np.array(Rq_q_values)


# plt.figure()
# plt.plot(Rq_gen_values, Rq_gen_values, 'o-')

# plt.figure()
# plt.plot(1/Rq_q_values, Rh_values, 'o-')
# plt.ylim([0, 5])
# plt.show()

# plt.figure()
# plt.plot(Rq_gen_values, Rq_gen_values, 'o-')
# plt.show()

# Plotting
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# Plot 1: Normalized mean flow vs Rq
ax = axes[0, 0]
ax.plot(Rq_q_values, mc_q_mean_normalized, 'ko', label='Monte Carlo', markersize=6, alpha=0.6)
ax.plot(Rq_q_values, analytical_mean_dom, 'b-', label='Mean-flow dominated\n$\\bar{q} = q_{AFN}\\sqrt{1-1/(R_Q^2)}$', linewidth=2)
ax.plot(Rq_q_values, analytical_fluct_dom, 'r--', label='Fluctuation dominated\n$\\bar{q} = q_{AFN}(2R_H)$', linewidth=2)
ax.plot(Rq_q_values, analytical_fluct_dom_bound, 'r:', label='Fluctuation dominated lower bound', linewidth=2)
ax.plot(Rq_q_values, analytical_fluct_tan, 'r-.', label='Fluctuation dominated tangent', linewidth=2)
# ax.plot(Rq_q_values, analytical_blend, 'g-', label='Blended model', linewidth=2.5)
ax.plot(Rq_q_values, analytical_blend_tan, 'g--', label='Blended model bound', linewidth=2.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5, label='$R_Q=1$ (validity limit)')
ax.axvline(x=tangent_bound, color='lightgray', linestyle=':', linewidth=1.5, label='blend bound')
ax.set_xlabel('$R_Q = q_{AFN}/\\sqrt{\\overline{(q\')^2}}$', fontsize=12)
ax.set_ylabel('$\\bar{q}/q_{AFN}$', fontsize=12)
ax.set_title('Normalized Mean Flow vs Fluctuation Ratio', fontsize=13, fontweight='bold')
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3)
ax.set_ylim([0, 1.5])

# Plot 2: Error between Monte Carlo and analytical
ax = axes[0, 1]
error_mean_dom = np.array(mc_q_mean_normalized) - np.array(analytical_mean_dom)
error_blend = np.array(mc_q_mean_normalized) - np.array(analytical_blend_tan)
ax.plot(Rq_q_values, error_mean_dom, 'b-', label='Mean-flow model error', linewidth=2)
ax.plot(Rq_q_values, error_blend, 'g-', label='Blended model error', linewidth=2)
ax.axhline(y=0, color='black', linestyle='-', linewidth=0.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.set_xlabel('$R_Q = q_{AFN}/\\sqrt{\\overline{(q\')^2}}$', fontsize=12)
ax.set_ylabel('Error in $\\bar{q}/q_{AFN}$', fontsize=12)
ax.set_title('Model Error vs Monte Carlo', fontsize=13, fontweight='bold')
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3)

# Plot 3: Absolute error (log scale)
ax = axes[1, 0]
ax.semilogy(Rq_gen_values, np.abs(error_mean_dom), 'b-', label='Mean-flow model', linewidth=2)
ax.semilogy(Rq_gen_values, np.abs(error_blend), 'g-', label='Blended model', linewidth=2)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.set_xlabel('$R_Q = q_{AFN}/\\sqrt{\\overline{(q\')^2}}$', fontsize=12)
ax.set_ylabel('Absolute Error (log scale)', fontsize=12)
ax.set_title('Absolute Model Error', fontsize=13, fontweight='bold')
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3, which='both')

# Plot 4: Blending function γ(Rq)
ax = axes[1, 1]
gamma_values = [gamma_blend_poly(Rq, blend_bound=blend_bound) for Rq in Rq_values]
ax.plot(Rq_q_values, gamma_values, 'purple', linewidth=2.5)
ax.axvline(x=1.0, color='gray', linestyle=':', linewidth=1.5)
ax.axvline(x=blend_bound, color='lightgray', linestyle=':', linewidth=1.5, label='blend bound')

ax.set_xlabel('$R_Q = q_{AFN}/\\sqrt{\\overline{(q\')^2}}$', fontsize=12)
ax.set_ylabel('$\\gamma(R_Q)$', fontsize=12)
ax.set_title('Blending Function (OVL-based)', fontsize=13, fontweight='bold')
ax.grid(True, alpha=0.3)
ax.set_ylim([0, 1])

plt.tight_layout()
plt.show()

# # Print summary statistics
# print("\n" + "="*60)
# print("SUMMARY STATISTICS")
# print("="*60)
# valid_regime = Rq_values < 1.0
# max_error_blend = np.max(np.abs(error_blend[valid_regime]))
# mean_error_blend = np.mean(np.abs(error_blend[valid_regime]))
# print(f"Blended model (Rq < 1.0):")
# print(f"  Max absolute error: {max_error_blend:.6f}")
# print(f"  Mean absolute error: {mean_error_blend:.6f}")