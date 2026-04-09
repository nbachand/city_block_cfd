#!/usr/bin/env python3
"""Monte Carlo study of correlated normals and lognormal ratio fitting."""

from typing import Tuple

import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import foldnorm, lognorm, ncf


def build_covariance(mu: float, correlation: float = 0.3) -> np.ndarray:
    """Build the covariance matrix for two normals with identical variance."""
    variance = 2 * mu
    covariance = correlation * variance
    return np.array([[variance, covariance], [covariance, variance]])


def simulate_ratio(
    mu: float,
    num_samples: int,
    correlation: float = 0.3,
    seed: int | None = None,
) -> np.ndarray:
    """Draw correlated normals and return the ratio of the first over the second."""
    covariance = build_covariance(mu, correlation)
    rng = np.random.default_rng(seed)
    samples = rng.multivariate_normal([mu, mu], covariance, size=num_samples)

    denominator = samples[:, 1]
    near_zero = np.isclose(denominator, 0.0, atol=1e-12)
    if near_zero.any():
        samples = samples[~near_zero]  # drop pathological draws to avoid singular ratios
    return np.abs(samples[:, 0] / samples[:, 1])


def fit_positive_lognormal(ratio: np.ndarray) -> Tuple[float, float, float]:
    """Fit a lognormal distribution to the positive subset of the ratio."""
    positive = ratio[ratio > 0]
    shape, loc, scale = lognorm.fit(positive, floc=0)
    return shape, loc, scale


def fit_ncf_distribution(ratio: np.ndarray) -> tuple[float, float, float, float, float]:
    """Fit a non-central F distribution to the positive subset of the ratio."""
    positive = ratio[ratio > 0]
    dfn, dfd, nc, loc, scale = ncf.fit(positive)
    return dfn, dfd, nc, loc, scale


def fit_foldnorm_distribution(ratio: np.ndarray) -> tuple[float, float, float]:
    """Fit a folded normal distribution to the positive subset of the ratio."""
    positive = ratio[ratio > 0]
    c, loc, scale = foldnorm.fit(positive)
    return c, loc, scale


def plot_ratio_distribution(
    ratio: np.ndarray,
    lognorm_params: Tuple[float, float, float],
    ncf_params: tuple[float, float, float, float, float],
    foldnorm_params: tuple[float, float, float],
) -> None:
    """Render the ratio histogram and overlay all three fitted PDFs."""
    positive = ratio[ratio > 0]
    shape, loc, scale = lognorm_params
    dfn, dfd, nc, ncf_loc, ncf_scale = ncf_params
    c, foldnorm_loc, foldnorm_scale = foldnorm_params
    x_max = np.percentile(positive, 95)

    plt.style.use("seaborn-v0_8")
    fig, ax = plt.subplots(figsize=(10, 5))
    ax.hist(positive[positive <= x_max], bins=500, density=True, alpha=0.4, label="Positive ratio draws")

    x = np.linspace(1e-6, x_max, 500)
    
    log_pdf = lognorm.pdf(x, shape, loc, scale)
    ax.plot(x, log_pdf, "r--", label="Lognormal fit", linewidth=2)
    
    ncf_pdf = ncf.pdf(x, dfn, dfd, nc, loc=ncf_loc, scale=ncf_scale)
    ax.plot(x, ncf_pdf, "g:", label="Non-central F fit", linewidth=2)
    
    foldnorm_pdf = foldnorm.pdf(x, c, loc=foldnorm_loc, scale=foldnorm_scale)
    ax.plot(x, foldnorm_pdf, "b-.", label="Folded normal fit", linewidth=2)
    
    ax.set_xlim(left=0, right=x_max)
    # Set y-limit based on histogram max to avoid distortion
    hist_max = ax.patches[0].get_height() if ax.patches else 1.0
    ax.set_ylim(bottom=0, top=max(log_pdf.max(), ncf_pdf.max(), foldnorm_pdf.max(), hist_max) * 1.2)
    ax.set_title("Ratio of correlated normals")
    ax.set_xlabel("ratio")
    ax.set_ylabel("density")
    ax.legend()
    plt.tight_layout()
    plt.show()


def run_simulation(
    mu: float = 1.0,
    num_samples: int = 100_000,
    correlation: float = 0.3,
    seed: int | None = None,
    plot: bool = True,
    ratio_max: float = 10.0,
) -> tuple[np.ndarray, tuple[float, float, float], tuple[float, float, float, float, float], tuple[float, float, float]]:
    """Run the full workflow and optionally plot all three fitted distributions."""
    ratio = simulate_ratio(mu, num_samples, correlation, seed)
    positive = ratio[ratio > 0]

    dropped = num_samples - ratio.size
    print(f"Simulated {ratio.size} ratios (dropped {dropped} invalid draws).")
    print(f"Positive ratios: {positive.size} ({positive.size/ratio.size*100:.1f}%).")

    print("-- Descriptive stats for positive ratios --")
    print(f"mean: {positive.mean():.4f}, std: {positive.std():.4f}")
    print(f"min: {positive.min():.4f}, max: {positive.max():.4f}")

    lognorm_params = fit_positive_lognormal(ratio)
    ncf_params = fit_ncf_distribution(ratio)
    foldnorm_params = fit_foldnorm_distribution(ratio)
    
    print("-- Lognormal fit parameters --")
    print(f"shape: {lognorm_params[0]:.4f}, loc: {lognorm_params[1]:.4f}, scale: {lognorm_params[2]:.4f}")
    print("-- Non-central F distribution fit parameters --")
    print(f"dfn: {ncf_params[0]:.4f}, dfd: {ncf_params[1]:.4f}, nc: {ncf_params[2]:.4f}, loc: {ncf_params[3]:.4f}, scale: {ncf_params[4]:.4f}")
    print("-- Folded normal fit parameters --")
    print(f"c: {foldnorm_params[0]:.4f}, loc: {foldnorm_params[1]:.4f}, scale: {foldnorm_params[2]:.4f}")

    if plot:
        plot_ratio_distribution(ratio, lognorm_params, ncf_params, foldnorm_params)

    return ratio, lognorm_params, ncf_params, foldnorm_params


if __name__ == "__main__":
    run_simulation()
