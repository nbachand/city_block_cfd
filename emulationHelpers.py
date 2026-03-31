import pandas as pd
import numpy as np
from scipy.optimize import curve_fit
from scipy.special import logsumexp
import seaborn as sns
import numpy as np
from matplotlib.colors import Normalize
from matplotlib.cm import ScalarMappable
import pyafn
from matplotlib import pyplot as plt
import pytensor.tensor as pt
from pytensor.compile.ops import wrap_py



@wrap_py(itypes=[pt.dvector, pt.dscalar, pt.dscalar], otypes=[pt.dvector])
def ventilation_redecomp_p_op(u_model, a, p_rms):
    """PyTensor wrapper around pyafn.ventilationReDecomp_p for scalar subgroup parameters."""
    return np.asarray(
        pyafn.ventilationReDecomp_p(np.asarray(u_model, dtype=float), float(a), float(p_rms)),
        dtype=float,
    )


@wrap_py(itypes=[pt.dvector, pt.dvector, pt.dvector], otypes=[pt.dvector])
def ventilation_redecomp_p_vector_op(u_model, a, p_rms):
    """PyTensor wrapper around pyafn.ventilationReDecomp_p for per-sample random parameters."""
    return np.asarray(
        pyafn.ventilationReDecomp_p(
            np.asarray(u_model, dtype=float),
            np.asarray(a, dtype=float),
            np.asarray(p_rms, dtype=float),
        ),
        dtype=float,
    )

def readEmulationMI(home_dir="./"):

    ############### Read #########
    multiRun_dir = f"{home_dir}/CHARLES/multiRuns/"
    plotFolder = f"{multiRun_dir}"

    roomVentilationMI = pd.read_csv(f"{multiRun_dir}/roomVentilationMIEmulation.csv", index_col = [0,1])
    flowStatsMI = pd.read_csv(f"{multiRun_dir}/flowStatsMIEmulation.csv", index_col=[0,1])


    ############### Augment and normalize #########
    df = flowStatsMI.copy()
    # df = df[df["slAll"] == False]
    # normalize x_cols. Flow quantities to be normalized by WS. Pressures to be normalized by W**2:

    # df['p-noInt_optp0-q_modelC_d'] = df['p-noInt_optp0-q_model'] * df['p-noInt_optp0-C_d']
    # for col in df.columns:
    #     if "mag" in col or "shear" in col or "normal" in col:
    #         df[col] = df[col] / df['p-noInt_optp0-q_modelC_d']

    df["skylight"] = df['openingType'].apply(lambda x: 1 if "skylight" in x else 0)
    df["cross"] = df['openingType'].apply(lambda x: 1 if "cross" in x else 0)
    df["single"] = df['openingType'].apply(lambda x: 1 if "single" in x else 0)
    df["dual"] = df['openingType'].apply(lambda x: 1 if "dual" in x else 0)
    df["corner"] = df['openingType'].apply(lambda x: 1 if "corner" in x else 0)
    Sdelp = np.sign(df['p-noInt_optp0-q_model'])
    Sdelp[Sdelp == 0] = 1  # Assign 1 to zero values
    df["Sdelp"] = Sdelp
    df["EP_shear-noInt-qIn"] = df["EP_shear-noInt"] * df["Sdelp"] > 0
    df["EP_shear-noInt-qOut"] = df["EP_shear-noInt"] * df["Sdelp"] <= 0
    df["EP_shear_o_qmodel"] = df["EP_shear-noInt"] / df["p-noInt_optp0-q_model"]
    df["rev-mass_flux"] =df["net-mass_flux"] -  df["mean-mass_flux"].abs()
    df["rev-mass_flux-Norm"] = df["rev-mass_flux"] / df["WS"]
    df["p_intensity-noInt"] = df["p_rms-noInt"] / df["p-noInt_optp0-q_model"]**2

    p_norm_cols = []
    u_norm_cols = []
    no_norm_cols = []
    for col in df.columns:
        if ("noInt" in col or col == "flux" or "EP" in col) and "Norm" not in col:
            if "-p0" in col or "p_" in col or "(p)" in col or "p0meas" in col or "u**2" in col:
                p_norm_cols.append(col)
            elif "mag" in col or "shear" in col or "normal" in col or "flux" in col or "(u" in col or "q_model" in col:
                u_norm_cols.append(col)
            else:
                no_norm_cols.append(col)

    print(f"Normalizing p cols: {sorted(p_norm_cols)}")
    print(f"Normalizing u cols: {sorted(u_norm_cols)}")
    print(f"Not normalizing cols: {sorted(no_norm_cols)}")

    # Normalize pressure columns by WS^2
    for col in p_norm_cols:
        df[f"{col}-Norm"] = df[col].div(df["WS"]**2, axis=0)
    # Normalize velocity columns by WS
    for col in u_norm_cols:
        df[f"{col}-Norm"] = df[col].div(df["WS"], axis=0)

    
    roomVentilationMI["flux-Norm"] = roomVentilationMI["flux"] / roomVentilationMI["WS"]
    roomVentilationMI["p-noInt_optp0-q_model-Norm"] = roomVentilationMI["p-noInt_optp0-q_model"] / roomVentilationMI["WS"]    


    grouped = df.groupby("WS").mean(numeric_only=True)
    ratio = grouped.loc[4] / grouped.loc[2]  # Should be about 4x difference`
    ratio = pd.DataFrame(ratio).reset_index()
    print(f"Ratio of grouped means: {ratio}")

    # Removing single sided no skylights
    print("Removing single sided no skylight rooms...")
    df = df[~((df["roomType"] == "single") & (df["slAll"] == False))]  # remove single rooms without skylights
    roomVentilationMI = roomVentilationMI[~((roomVentilationMI["roomType"] == "single") & (roomVentilationMI["slAll"] == False))]  # remove single rooms without skylights

    df["all"] = True

    return df, roomVentilationMI


def prepare_bayesian_ventilation_subgroup(data, y_var, x_var, skylight, sdelp):
    """Prepare one Window/Skylight and Entering/Exiting subgroup for Bayesian fitting."""
    sl_val = bool(skylight)
    title = "Skylight" if sl_val else "Window"
    direction = "Flow Entering" if int(sdelp) > 0 else "Flow Exiting"

    plotdf = data[data["skylight"] == sl_val].copy()
    regdf = plotdf.loc[plotdf["Sdelp"] == int(sdelp), [x_var, y_var]].copy()
    regdf_abs = regdf.abs().sort_values(by=x_var)

    return {
        "title": title,
        "direction": direction,
        "skylight": sl_val,
        "sdelp": int(sdelp),
        "plotdf": plotdf,
        "fitdf_abs": regdf_abs,
        "u_model": regdf_abs[x_var].to_numpy(dtype=float),
        "y_obs": regdf_abs[y_var].to_numpy(dtype=float),
    }


def _lognormal_mean(mu, sigma):
    return np.exp(mu + 0.5 * sigma**2)


def _lognormal_sd(mu, sigma):
    return np.sqrt((np.exp(sigma**2) - 1.0) * np.exp(2.0 * mu + sigma**2))


def _gamma_alpha_beta(mean, sd):
    mean = np.maximum(np.asarray(mean, dtype=float), 1e-8)
    sd = np.maximum(np.asarray(sd, dtype=float), 1e-8)
    alpha = (mean / sd) ** 2
    beta = mean / (sd**2)
    return alpha, beta


def _summarize_parameter_draws(parameter_draws):
    summary = parameter_draws.describe(percentiles=[0.03, 0.5, 0.97]).T
    summary = summary.rename(
        columns={
            "50%": "median",
            "std": "sd",
            "3%": "hdi_3%",
            "97%": "hdi_97%",
        }
    )
    return summary[["mean", "sd", "hdi_3%", "median", "hdi_97%"]]


_population_normal_cache = {}


def _get_standard_normal_pairs(mc_draws, random_seed):
    key = (int(mc_draws), int(random_seed))
    if key not in _population_normal_cache:
        rng = np.random.default_rng(int(random_seed))
        _population_normal_cache[key] = (
            rng.standard_normal(int(mc_draws)),
            rng.standard_normal(int(mc_draws)),
        )
    return _population_normal_cache[key]


def _population_mixture_loglike_from_samples(u_model, y_obs, a_samples, p_rms_samples, sigma_obs):
    u_model = np.asarray(u_model, dtype=float)
    y_obs = np.asarray(y_obs, dtype=float)
    a_samples = np.asarray(a_samples, dtype=float)
    p_rms_samples = np.asarray(p_rms_samples, dtype=float)
    sigma_obs = max(float(sigma_obs), 1e-8)

    target_shape = (len(a_samples), len(u_model))
    u_eval = np.broadcast_to(u_model[np.newaxis, :], target_shape)
    a_eval = np.broadcast_to(a_samples[:, np.newaxis], target_shape)
    p_eval = np.broadcast_to(p_rms_samples[:, np.newaxis], target_shape)
    y_model_draws = np.asarray(
        pyafn.ventilationReDecomp_p(u_eval, a_eval, p_eval),
        dtype=float,
    )
    if y_model_draws.ndim == 1:
        y_model_draws = y_model_draws[np.newaxis, :]

    residual = (y_obs[np.newaxis, :] - y_model_draws) / sigma_obs
    logpdf = -0.5 * residual**2 - np.log(sigma_obs) - 0.5 * np.log(2.0 * np.pi)
    per_obs = logsumexp(logpdf, axis=0) - np.log(y_model_draws.shape[0])
    return np.array(float(np.sum(per_obs)), dtype=float)


@wrap_py(
    itypes=[pt.dvector, pt.dvector, pt.dscalar, pt.dscalar, pt.dscalar, pt.dscalar, pt.dscalar, pt.lscalar, pt.lscalar],
    otypes=[pt.dscalar],
)
def ventilation_redecomp_p_lognormal_population_loglike_op(
    u_model,
    y_obs,
    mu_log_a,
    sigma_log_a,
    mu_log_p_rms,
    sigma_log_p_rms,
    sigma_obs,
    mc_draws,
    random_seed,
):
    z_a, z_p = _get_standard_normal_pairs(mc_draws, random_seed)
    sigma_log_a = max(float(sigma_log_a), 1e-8)
    sigma_log_p_rms = max(float(sigma_log_p_rms), 1e-8)
    a_samples = np.exp(float(mu_log_a) + sigma_log_a * z_a)
    p_rms_samples = np.exp(float(mu_log_p_rms) + sigma_log_p_rms * z_p)
    return _population_mixture_loglike_from_samples(u_model, y_obs, a_samples, p_rms_samples, sigma_obs)


@wrap_py(
    itypes=[pt.dvector, pt.dvector, pt.dscalar, pt.dscalar, pt.dscalar, pt.dscalar, pt.dscalar, pt.lscalar, pt.lscalar],
    otypes=[pt.dscalar],
)
def ventilation_redecomp_p_gamma_population_loglike_op(
    u_model,
    y_obs,
    a_dist_mean,
    a_dist_sd,
    p_rms_dist_mean,
    p_rms_dist_sd,
    sigma_obs,
    mc_draws,
    random_seed,
):
    a_alpha, a_beta = _gamma_alpha_beta(a_dist_mean, a_dist_sd)
    p_alpha, p_beta = _gamma_alpha_beta(p_rms_dist_mean, p_rms_dist_sd)
    rng = np.random.default_rng(int(random_seed))
    a_samples = rng.gamma(shape=float(a_alpha), scale=1.0 / float(a_beta), size=int(mc_draws))
    p_rms_samples = rng.gamma(shape=float(p_alpha), scale=1.0 / float(p_beta), size=int(mc_draws))
    return _population_mixture_loglike_from_samples(u_model, y_obs, a_samples, p_rms_samples, sigma_obs)


def fit_bayesian_pressure_subgroup(
    u_model,
    y_obs,
    *,
    parameter_family="lognormal",
    family_kwargs=None,
    obs_sigma=0.1,
    mc_draws=128,
    likelihood_seed=42,
    random_seed=42,
    sample_kwargs=None,
):
    """Fit subgroup-level parameter distributions to one ventilation subgroup with PyMC."""
    import pymc as pm

    family = str(parameter_family).lower()
    family_kwargs = dict(family_kwargs or {})

    u_model = np.asarray(u_model, dtype=float)
    y_obs = np.asarray(y_obs, dtype=float)
    if u_model.ndim != 1 or y_obs.ndim != 1:
        raise ValueError("u_model and y_obs must be 1D arrays.")
    if len(u_model) != len(y_obs):
        raise ValueError("u_model and y_obs must have the same length.")
    if len(u_model) == 0:
        raise ValueError("Cannot fit a subgroup with zero samples.")

    sample_kwargs_local = dict(sample_kwargs or {})

    with pm.Model():
        u_model_data = pm.Data("u_model", u_model)
        y_obs_data = pm.Data("y_obs", y_obs)
        mc_draws_data = pt.as_tensor_variable(np.int64(mc_draws))
        likelihood_seed_data = pt.as_tensor_variable(np.int64(likelihood_seed))
        sigma_obs = pm.HalfNormal("sigma_obs", sigma=obs_sigma)

        if family == "lognormal":
            mu_log_a_sigma = family_kwargs.get("mu_log_a_sigma", 1.0)
            sigma_log_a_sigma = family_kwargs.get("sigma_log_a_sigma", 1.0)
            mu_log_p_rms_center = family_kwargs.get("mu_log_p_rms_center", np.log(0.05))
            mu_log_p_rms_sigma = family_kwargs.get("mu_log_p_rms_sigma", 1.5)
            sigma_log_p_rms_sigma = family_kwargs.get("sigma_log_p_rms_sigma", 1.0)

            mu_log_a = pm.Normal("mu_log_a", mu=0.0, sigma=mu_log_a_sigma)
            sigma_log_a = pm.HalfNormal("sigma_log_a", sigma=sigma_log_a_sigma)
            mu_log_p_rms = pm.Normal("mu_log_p_rms", mu=mu_log_p_rms_center, sigma=mu_log_p_rms_sigma)
            sigma_log_p_rms = pm.HalfNormal("sigma_log_p_rms", sigma=sigma_log_p_rms_sigma)

            pm.Potential(
                "population_loglike",
                ventilation_redecomp_p_lognormal_population_loglike_op(
                    u_model_data,
                    y_obs_data,
                    mu_log_a,
                    sigma_log_a,
                    mu_log_p_rms,
                    sigma_log_p_rms,
                    sigma_obs,
                    mc_draws_data,
                    likelihood_seed_data,
                ),
            )
        elif family == "gamma":
            a_mean_sigma = family_kwargs.get("a_mean_sigma", 2.0)
            a_sd_sigma = family_kwargs.get("a_sd_sigma", 1.0)
            p_rms_mean_sigma = family_kwargs.get("p_rms_mean_sigma", 0.1)
            p_rms_sd_sigma = family_kwargs.get("p_rms_sd_sigma", 0.1)

            a_dist_mean = pm.HalfNormal("a_dist_mean", sigma=a_mean_sigma)
            a_dist_sd = pm.HalfNormal("a_dist_sd", sigma=a_sd_sigma)
            p_rms_dist_mean = pm.HalfNormal("p_rms_dist_mean", sigma=p_rms_mean_sigma)
            p_rms_dist_sd = pm.HalfNormal("p_rms_dist_sd", sigma=p_rms_sd_sigma)

            pm.Potential(
                "population_loglike",
                ventilation_redecomp_p_gamma_population_loglike_op(
                    u_model_data,
                    y_obs_data,
                    a_dist_mean,
                    a_dist_sd,
                    p_rms_dist_mean,
                    p_rms_dist_sd,
                    sigma_obs,
                    mc_draws_data,
                    likelihood_seed_data,
                ),
            )
        else:
            raise ValueError("parameter_family must be 'lognormal' or 'gamma'.")

        sample_kwargs_local.setdefault("draws", 1000)
        sample_kwargs_local.setdefault("tune", 1000)
        sample_kwargs_local.setdefault("chains", 4)
        sample_kwargs_local.setdefault("cores", 4)
        sample_kwargs_local.setdefault("progressbar", True)
        sample_kwargs_local.setdefault("step", pm.Slice())
        sample_kwargs_local.setdefault("random_seed", random_seed)

        idata = pm.sample(**sample_kwargs_local)

    posterior = idata.posterior
    sigma_obs_vals = np.asarray(posterior["sigma_obs"].values).reshape(-1)

    if family == "lognormal":
        mu_log_a_vals = np.asarray(posterior["mu_log_a"].values).reshape(-1)
        sigma_log_a_vals = np.asarray(posterior["sigma_log_a"].values).reshape(-1)
        mu_log_p_vals = np.asarray(posterior["mu_log_p_rms"].values).reshape(-1)
        sigma_log_p_vals = np.asarray(posterior["sigma_log_p_rms"].values).reshape(-1)
        parameter_draws = pd.DataFrame(
            {
                "a_dist_mean": _lognormal_mean(mu_log_a_vals, sigma_log_a_vals),
                "a_dist_sd": _lognormal_sd(mu_log_a_vals, sigma_log_a_vals),
                "p_rms_dist_mean": _lognormal_mean(mu_log_p_vals, sigma_log_p_vals),
                "p_rms_dist_sd": _lognormal_sd(mu_log_p_vals, sigma_log_p_vals),
                "sigma_obs": sigma_obs_vals,
                "mu_log_a": mu_log_a_vals,
                "sigma_log_a": sigma_log_a_vals,
                "mu_log_p_rms": mu_log_p_vals,
                "sigma_log_p_rms": sigma_log_p_vals,
            }
        )
    else:
        parameter_draws = pd.DataFrame(
            {
                "a_dist_mean": np.asarray(posterior["a_dist_mean"].values).reshape(-1),
                "a_dist_sd": np.asarray(posterior["a_dist_sd"].values).reshape(-1),
                "p_rms_dist_mean": np.asarray(posterior["p_rms_dist_mean"].values).reshape(-1),
                "p_rms_dist_sd": np.asarray(posterior["p_rms_dist_sd"].values).reshape(-1),
                "sigma_obs": sigma_obs_vals,
            }
        )

    summary = _summarize_parameter_draws(parameter_draws)
    distribution_median = {
        "a_dist_mean": float(np.median(parameter_draws["a_dist_mean"])),
        "a_dist_sd": float(np.median(parameter_draws["a_dist_sd"])),
        "p_rms_dist_mean": float(np.median(parameter_draws["p_rms_dist_mean"])),
        "p_rms_dist_sd": float(np.median(parameter_draws["p_rms_dist_sd"])),
        "sigma_obs": float(np.median(parameter_draws["sigma_obs"])),
    }

    return {
        "idata": idata,
        "summary": summary,
        "parameter_draws": parameter_draws,
        "distribution_median": distribution_median,
        "parameter_family": family,
        "family_kwargs": family_kwargs,
        "mc_draws": int(mc_draws),
        "likelihood_seed": int(likelihood_seed),
        "n_obs": len(u_model),
    }


def _parameter_draws_from_idata(idata, family):
    posterior = idata.posterior
    sigma_obs_vals = np.asarray(posterior["sigma_obs"].values).reshape(-1)

    if family == "lognormal":
        mu_log_a_vals = np.asarray(posterior["mu_log_a"].values).reshape(-1)
        sigma_log_a_vals = np.asarray(posterior["sigma_log_a"].values).reshape(-1)
        mu_log_p_vals = np.asarray(posterior["mu_log_p_rms"].values).reshape(-1)
        sigma_log_p_vals = np.asarray(posterior["sigma_log_p_rms"].values).reshape(-1)
        return pd.DataFrame(
            {
                "a_dist_mean": _lognormal_mean(mu_log_a_vals, sigma_log_a_vals),
                "a_dist_sd": _lognormal_sd(mu_log_a_vals, sigma_log_a_vals),
                "p_rms_dist_mean": _lognormal_mean(mu_log_p_vals, sigma_log_p_vals),
                "p_rms_dist_sd": _lognormal_sd(mu_log_p_vals, sigma_log_p_vals),
                "sigma_obs": sigma_obs_vals,
                "mu_log_a": mu_log_a_vals,
                "sigma_log_a": sigma_log_a_vals,
                "mu_log_p_rms": mu_log_p_vals,
                "sigma_log_p_rms": sigma_log_p_vals,
            }
        )

    return pd.DataFrame(
        {
            "a_dist_mean": np.asarray(posterior["a_dist_mean"].values).reshape(-1),
            "a_dist_sd": np.asarray(posterior["a_dist_sd"].values).reshape(-1),
            "p_rms_dist_mean": np.asarray(posterior["p_rms_dist_mean"].values).reshape(-1),
            "p_rms_dist_sd": np.asarray(posterior["p_rms_dist_sd"].values).reshape(-1),
            "sigma_obs": sigma_obs_vals,
        }
    )


def _distribution_median_from_parameter_draws(parameter_draws):
    return {
        "a_dist_mean": float(np.median(parameter_draws["a_dist_mean"])),
        "a_dist_sd": float(np.median(parameter_draws["a_dist_sd"])),
        "p_rms_dist_mean": float(np.median(parameter_draws["p_rms_dist_mean"])),
        "p_rms_dist_sd": float(np.median(parameter_draws["p_rms_dist_sd"])),
        "sigma_obs": float(np.median(parameter_draws["sigma_obs"])),
    }


def posterior_predict_bayesian_pressure_curve(
    fit_result,
    x_grid,
    *,
    sign=1,
    credible_interval=0.95,
    posterior_draws_for_curves=300,
    latent_draws_per_posterior=50,
    include_obs_noise=True,
    random_seed=42,
):
    """Generate output or posterior-predictive bands from Bayesian ventilation fits."""
    x_grid = np.asarray(x_grid, dtype=float)
    if x_grid.ndim != 1:
        raise ValueError("x_grid must be a 1D array.")
    if len(x_grid) == 0:
        raise ValueError("x_grid must contain at least one point.")

    parameter_draws = fit_result["parameter_draws"].reset_index(drop=True)
    if posterior_draws_for_curves is not None and len(parameter_draws) > posterior_draws_for_curves:
        idx = np.linspace(0, len(parameter_draws) - 1, posterior_draws_for_curves, dtype=int)
        parameter_draws = parameter_draws.iloc[idx].reset_index(drop=True)

    rng = np.random.default_rng(random_seed)
    y_draws = []
    family = fit_result["parameter_family"]
    for row in parameter_draws.itertuples(index=False):
        if family == "lognormal":
            a_draws = rng.lognormal(mean=row.mu_log_a, sigma=row.sigma_log_a, size=latent_draws_per_posterior)
            p_draws = rng.lognormal(mean=row.mu_log_p_rms, sigma=row.sigma_log_p_rms, size=latent_draws_per_posterior)
        else:
            a_alpha, a_beta = _gamma_alpha_beta(row.a_dist_mean, row.a_dist_sd)
            p_alpha, p_beta = _gamma_alpha_beta(row.p_rms_dist_mean, row.p_rms_dist_sd)
            a_draws = rng.gamma(shape=a_alpha, scale=1.0 / a_beta, size=latent_draws_per_posterior)
            p_draws = rng.gamma(shape=p_alpha, scale=1.0 / p_beta, size=latent_draws_per_posterior)

        target_shape = (len(a_draws), len(x_grid))
        x_eval = np.broadcast_to(x_grid[np.newaxis, :], target_shape)
        a_eval = np.broadcast_to(np.asarray(a_draws)[:, np.newaxis], target_shape)
        p_eval = np.broadcast_to(np.asarray(p_draws)[:, np.newaxis], target_shape)
        y_draw_block = np.asarray(
            pyafn.ventilationReDecomp_p(x_eval, a_eval, p_eval),
            dtype=float,
        )
        if include_obs_noise:
            sigma_obs = max(float(row.sigma_obs), 1e-8)
            y_draw_block = y_draw_block + rng.normal(
                loc=0.0,
                scale=sigma_obs,
                size=y_draw_block.shape,
            )
        y_draws.append(y_draw_block)

    y_draws = sign * np.vstack(y_draws)
    if sign < 0:
        x_plot = -x_grid[::-1]
        y_draws = y_draws[:, ::-1]
    else:
        x_plot = x_grid

    alpha = (1.0 - credible_interval) / 2.0
    return {
        "x": x_plot,
        "median": np.quantile(y_draws, 0.5, axis=0),
        "lower": np.quantile(y_draws, alpha, axis=0),
        "upper": np.quantile(y_draws, 1.0 - alpha, axis=0),
    }


def summarize_bayesian_ventilation_fits(fit_results):
    """Combine subgroup summaries from Bayesian ventilation subgroup fits."""
    rows = []
    for (title, direction), result in fit_results.items():
        summary = result["summary"].copy().reset_index()
        first_col = summary.columns[0]
        summary = summary.rename(columns={first_col: "parameter"})
        summary.insert(0, "family", result.get("parameter_family", "unknown"))
        summary.insert(1, "n_obs", result.get("n_obs", np.nan))
        summary.insert(2, "direction", direction)
        summary.insert(2, "panel", title)
        rows.append(summary)

    if not rows:
        return pd.DataFrame(columns=["panel", "direction", "family", "n_obs", "parameter"])
    return pd.concat(rows, ignore_index=True)


def save_bayesian_ventilation_fit_results(fit_results, output_dir):
    """Save Bayesian subgroup MCMC results to disk using NetCDF plus JSON metadata."""
    import json
    from pathlib import Path

    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    metadata = {"format_version": 1, "entries": []}
    for (title, direction), result in fit_results.items():
        slug = f"{title.lower().replace(' ', '_')}__{direction.lower().replace(' ', '_')}"
        idata_file = f"{slug}.nc"
        idata_path = output_dir / idata_file
        result["idata"].to_netcdf(idata_path)

        subgroup = result.get("subgroup", {})
        metadata["entries"].append(
            {
                "panel": title,
                "direction": direction,
                "idata_file": idata_file,
                "parameter_family": result.get("parameter_family", "unknown"),
                "family_kwargs": result.get("family_kwargs", {}),
                "mc_draws": int(result.get("mc_draws", 0)),
                "likelihood_seed": int(result.get("likelihood_seed", 0)),
                "n_obs": int(result.get("n_obs", 0)),
                "sign": int(result.get("sign", 1)),
                "subgroup": {
                    "title": subgroup.get("title", title),
                    "direction": subgroup.get("direction", direction),
                    "skylight": bool(subgroup.get("skylight", title == "Skylight")),
                    "sdelp": int(subgroup.get("sdelp", 1 if direction == "Flow Entering" else -1)),
                    "u_model": np.asarray(subgroup.get("u_model", []), dtype=float).tolist(),
                    "y_obs": np.asarray(subgroup.get("y_obs", []), dtype=float).tolist(),
                },
            }
        )

    (output_dir / "metadata.json").write_text(json.dumps(metadata, indent=2))
    summarize_bayesian_ventilation_fits(fit_results).to_csv(output_dir / "summary.csv", index=False)
    return output_dir


def load_bayesian_ventilation_fit_results(output_dir):
    """Load saved Bayesian subgroup MCMC results from NetCDF plus JSON metadata."""
    import json
    from pathlib import Path
    import arviz as az

    output_dir = Path(output_dir)
    metadata = json.loads((output_dir / "metadata.json").read_text())
    fit_results = {}

    for entry in metadata.get("entries", []):
        title = entry["panel"]
        direction = entry["direction"]
        family = entry.get("parameter_family", "unknown")
        idata = az.from_netcdf(output_dir / entry["idata_file"])
        parameter_draws = _parameter_draws_from_idata(idata, family)
        subgroup_meta = entry.get("subgroup", {})
        subgroup = {
            "title": subgroup_meta.get("title", title),
            "direction": subgroup_meta.get("direction", direction),
            "skylight": bool(subgroup_meta.get("skylight", title == "Skylight")),
            "sdelp": int(subgroup_meta.get("sdelp", 1 if direction == "Flow Entering" else -1)),
            "u_model": np.asarray(subgroup_meta.get("u_model", []), dtype=float),
            "y_obs": np.asarray(subgroup_meta.get("y_obs", []), dtype=float),
        }
        fit_results[(title, direction)] = {
            "idata": idata,
            "summary": _summarize_parameter_draws(parameter_draws),
            "parameter_draws": parameter_draws,
            "distribution_median": _distribution_median_from_parameter_draws(parameter_draws),
            "parameter_family": family,
            "family_kwargs": entry.get("family_kwargs", {}),
            "mc_draws": int(entry.get("mc_draws", 0)),
            "likelihood_seed": int(entry.get("likelihood_seed", 0)),
            "n_obs": int(entry.get("n_obs", len(subgroup["u_model"]))),
            "sign": int(entry.get("sign", 1)),
            "subgroup": subgroup,
        }

    return fit_results


def fit_bayesian_ventilation_p_subgroups(
    data,
    y_var,
    x_var,
    *,
    parameter_family="lognormal",
    family_kwargs=None,
    obs_sigma=0.1,
    mc_draws=128,
    likelihood_seed=42,
    sample_kwargs=None,
    random_seed=42,
):
    """Fit all Window/Skylight and Entering/Exiting Bayesian subgroups without plotting."""
    fit_results = {}
    for i in range(2):
        sl_val = bool(i)
        title = "Skylight" if sl_val else "Window"
        for j, (s, lbl) in enumerate([(1, "Flow Entering"), (-1, "Flow Exiting")]):
            subgroup = prepare_bayesian_ventilation_subgroup(data, y_var, x_var, sl_val, s)
            regdf_abs = subgroup["fitdf_abs"]
            if regdf_abs.empty:
                print(f"Skipping Bayesian fit for {title}, {lbl}: no samples")
                continue

            fit_result = fit_bayesian_pressure_subgroup(
                subgroup["u_model"],
                subgroup["y_obs"],
                parameter_family=parameter_family,
                family_kwargs=family_kwargs,
                obs_sigma=obs_sigma,
                mc_draws=mc_draws,
                likelihood_seed=likelihood_seed + i * 10 + j,
                random_seed=random_seed + i * 10 + j,
                sample_kwargs=sample_kwargs,
            )

            fit_result["subgroup"] = subgroup
            fit_result["sign"] = s
            fit_results[(title, lbl)] = fit_result

            dist = fit_result["distribution_median"]
            print(
                f"Bayesian distribution fit {title}, {lbl} ({parameter_family}): "
                f"a_mean={dist['a_dist_mean']:.4f}, a_sd={dist['a_dist_sd']:.4f}, "
                f"p_rms_mean={dist['p_rms_dist_mean']:.4f}, p_rms_sd={dist['p_rms_dist_sd']:.4f}, "
                f"sigma_obs={dist['sigma_obs']:.4f}"
            )

    return fit_results


def plot_bayesian_ventilation_p_fit_results(
    data,
    fit_results,
    y_var,
    x_var,
    *,
    hue="roomType",
    style="slAll",
    model_name="Bayesian Pressure Ventilation Model",
    credible_interval=0.95,
    posterior_draws_for_curves=300,
    latent_draws_per_posterior=50,
    include_obs_noise=True,
    curve_points=200,
    random_seed=42,
    axes=None,
    show_row_titles=True,
    set_axis_labels=True,
    show_figure_legend=True,
    add_numeric_colorbar=False,
    hue_norm=None,
    palette_numeric="viridis",
    figure_suptitle=True,
    colorbar_rect=None,
    colorbar_orientation="horizontal",
    xlim=(-0.6, 0.6),
    ylim=(-0.6, 0.6),
    show_scatter=True,
    scatter_alpha=0.6,
    scatter_size=20,
    band_alpha=0.3,
    band_color="0.5",
    scatter_zorder=1,
    band_zorder=2,
    line_zorder=3,
):
    """Plot previously-fitted Bayesian ventilation subgroup results."""
    data = data.copy()
    using_external_axes = axes is not None
    if using_external_axes:
        axs = np.array(axes).flatten()
        if len(axs) < 2:
            raise ValueError("When providing axes, pass at least two axes (Window, Skylight).")
        axs = axs[:2]
        fig = axs[0].figure
    else:
        fig, axs = plt.subplots(1, 2, figsize=(12, 6), dpi=140, sharex=True, sharey=True)
        axs = np.array(axs).flatten()

    for ax in axs:
        ax.grid(True, alpha=0.3)
        ax.tick_params(labelsize=16)
        if set_axis_labels:
            ax.set_xlabel("Modeled Flux Velocity", fontsize=20)
            ax.set_ylabel("LES Flux Velocity", fontsize=20)
        if xlim is not None:
            ax.set_xlim(*xlim)
        if ylim is not None:
            ax.set_ylim(*ylim)

    hue_is_numeric = pd.api.types.is_numeric_dtype(data[hue])
    if hue_is_numeric and hue_norm is None:
        finite_vals = pd.to_numeric(data[hue], errors="coerce")
        finite_vals = finite_vals[np.isfinite(finite_vals)]
        if len(finite_vals) > 0:
            hue_norm = Normalize(vmin=finite_vals.min(), vmax=finite_vals.max())

    scatter_collection_for_cbar = None

    for i in range(2):
        sl_val = bool(i)
        plotdf = data[data["skylight"] == sl_val].copy()
        plotdf = plotdf.sort_values(by=[hue, style])

        min_val = min(plotdf[x_var].min(), plotdf[y_var].min())
        max_val = max(plotdf[x_var].max(), plotdf[y_var].max())
        xs = np.array([min_val, max_val])
        axs[i].plot(xs, xs, "r--", label="1:1 Line", zorder=0)

        title = "Skylight" if sl_val else "Window"
        if show_row_titles:
            axs[i].set_title(title, fontsize=20)

        for j, (s, stl, lbl) in enumerate([(1, "-", "Flow Entering"), (-1, "-", "Flow Exiting")]):
            fit_result = fit_results.get((title, lbl))
            if fit_result is None:
                continue
            subgroup = fit_result.get("subgroup")
            if subgroup is None or len(subgroup["u_model"]) == 0:
                continue
            x_min = subgroup["u_model"].min()
            x_max = subgroup["u_model"].max()
            if np.isclose(x_min, x_max):
                x_grid = np.array([x_min], dtype=float)
            else:
                x_grid = np.linspace(x_min, x_max, curve_points)
            curve = posterior_predict_bayesian_pressure_curve(
                fit_result,
                x_grid,
                sign=s,
                credible_interval=credible_interval,
                posterior_draws_for_curves=posterior_draws_for_curves,
                latent_draws_per_posterior=latent_draws_per_posterior,
                include_obs_noise=include_obs_noise,
                random_seed=random_seed + 1000 + i * 10 + j,
            )
            fit_result["curve"] = curve

            band_name = "Posterior Predictive Band" if include_obs_noise else "Output Band"
            band_label = f"{int(credible_interval * 100)}% {band_name}" if s > 0 else None
            line_label = f"Output Median ({fit_result.get('parameter_family', 'unknown')})" if s > 0 else None
            axs[i].fill_between(
                curve["x"],
                curve["lower"],
                curve["upper"],
                color=band_color,
                alpha=band_alpha,
                label=band_label,
                zorder=band_zorder,
            )
            axs[i].plot(
                curve["x"],
                curve["median"],
                color="k",
                linestyle=stl,
                linewidth=2.5,
                label=line_label,
                zorder=line_zorder,
            )

        scatter_ax = None
        if show_scatter:
            legend_mode = "auto"
            if hue_is_numeric:
                legend_mode = False
            scatter_ax = sns.scatterplot(
                data=plotdf,
                x=x_var,
                y=y_var,
                hue=hue,
                style=style,
                alpha=scatter_alpha,
                s=scatter_size,
                ax=axs[i],
                palette=palette_numeric if hue_is_numeric else "colorblind",
                hue_norm=hue_norm if hue_is_numeric else None,
                legend=legend_mode,
                zorder=scatter_zorder,
            )
            if hue_is_numeric and len(scatter_ax.collections) > 0:
                scatter_collection_for_cbar = scatter_ax.collections[0]
                if scatter_collection_for_cbar is not None:
                    scatter_collection_for_cbar.set_cmap(palette_numeric)
                    if hue_norm is not None:
                        scatter_collection_for_cbar.set_norm(hue_norm)

    handles, labels = axs[0].get_legend_handles_labels()
    for ax in axs:
        if ax.get_legend() is not None:
            ax.get_legend().remove()
    filtered = [(h, l) for h, l in zip(handles, labels) if l not in (None, "", "_nolegend_")]
    handles = [h for h, _ in filtered]
    labels = [l for _, l in filtered]

    if show_figure_legend and (not hue_is_numeric) and len(handles) > 0:
        if using_external_axes:
            fig.legend(handles, labels, loc="lower center", bbox_to_anchor=(0.5, -0.02),
                       fontsize=16, ncol=min(5, len(labels)), frameon=False)
        else:
            fig.legend(handles, labels, loc="center left", bbox_to_anchor=(0.93, 0.5),
                       fontsize=16, frameon=False)

    if add_numeric_colorbar and hue_is_numeric and scatter_collection_for_cbar is not None:
        colorbar_orientation = str(colorbar_orientation).lower()
        if colorbar_orientation not in ("horizontal", "vertical"):
            raise ValueError("colorbar_orientation must be 'horizontal' or 'vertical'.")
        if colorbar_rect is None:
            if colorbar_orientation == "vertical":
                colorbar_rect = (0.94, 0.15, 0.02, 0.7)
            else:
                colorbar_rect = (0.20, -0.03, 0.60, 0.03)
        cbar_ax = fig.add_axes(tuple(colorbar_rect))
        cbar_norm = hue_norm if hue_norm is not None else Normalize()
        cbar_mappable = ScalarMappable(norm=cbar_norm, cmap=palette_numeric)
        cbar_mappable.set_array([])
        cbar = fig.colorbar(cbar_mappable, cax=cbar_ax, orientation=colorbar_orientation)
        cbar.set_label(hue, fontsize=20)
        cbar.ax.tick_params(labelsize=20)

    families = sorted({result.get("parameter_family", "unknown") for result in fit_results.values()})
    if figure_suptitle:
        family_label = ", ".join(f.title() for f in families) if families else "Unknown"
        fig.suptitle(f"{model_name}: Output Distribution Bands from {family_label} Parameters", fontsize=20)

    if not using_external_axes:
        plt.tight_layout(rect=[0, 0, 0.92, 0.95])

    return fig, axs


def plot_bayesian_ventilation_p_fit(
    data,
    y_var,
    x_var,
    hue="roomType",
    style="slAll",
    model_name="Bayesian Pressure Ventilation Model",
    parameter_family="lognormal",
    family_kwargs=None,
    credible_interval=0.95,
    obs_sigma=0.1,
    mc_draws=128,
    likelihood_seed=42,
    sample_kwargs=None,
    random_seed=42,
    posterior_draws_for_curves=300,
    latent_draws_per_posterior=50,
    include_obs_noise=True,
    curve_points=200,
    axes=None,
    show_row_titles=True,
    set_axis_labels=True,
    show_figure_legend=True,
    add_numeric_colorbar=False,
    hue_norm=None,
    palette_numeric="viridis",
    figure_suptitle=True,
    colorbar_rect=None,
    colorbar_orientation="horizontal",
    xlim=(-0.6, 0.6),
    ylim=(-0.6, 0.6),
    band_alpha=0.3,
    band_color="0.5",
    band_zorder=1,
    line_zorder=2,
    scatter_zorder=3,
    return_fits=False,
):
    """Fit Bayesian ventilation subgroups and plot the resulting output bands."""
    fit_results = fit_bayesian_ventilation_p_subgroups(
        data,
        y_var,
        x_var,
        parameter_family=parameter_family,
        family_kwargs=family_kwargs,
        obs_sigma=obs_sigma,
        mc_draws=mc_draws,
        likelihood_seed=likelihood_seed,
        sample_kwargs=sample_kwargs,
        random_seed=random_seed,
    )
    fig, axs = plot_bayesian_ventilation_p_fit_results(
        data,
        fit_results,
        y_var,
        x_var,
        hue=hue,
        style=style,
        model_name=model_name,
        credible_interval=credible_interval,
        posterior_draws_for_curves=posterior_draws_for_curves,
        latent_draws_per_posterior=latent_draws_per_posterior,
        include_obs_noise=include_obs_noise,
        curve_points=curve_points,
        random_seed=random_seed,
        axes=axes,
        show_row_titles=show_row_titles,
        set_axis_labels=set_axis_labels,
        show_figure_legend=show_figure_legend,
        add_numeric_colorbar=add_numeric_colorbar,
        hue_norm=hue_norm,
        palette_numeric=palette_numeric,
        figure_suptitle=figure_suptitle,
        colorbar_rect=colorbar_rect,
        colorbar_orientation=colorbar_orientation,
        xlim=xlim,
        ylim=ylim,
        band_alpha=band_alpha,
        band_color=band_color,
        scatter_zorder=scatter_zorder,
        band_zorder=band_zorder,
        line_zorder=line_zorder,
    )
    if return_fits:
        return fig, axs, fit_results
    return fig, axs


def plot_ventilation_model_fit(data, y_var, x_var, x_var2=None, hue="roomType", style="slAll",
                                model_func=pyafn.ventilationReDecomp_q, model_name="Ventilation Model",
                                p0=[1.0, 0.5, 1.0], bounds=([0.1, 0, 0], [np.inf, np.inf, 2]),
                                adjustData=False, show_assymptotes=False,
                                group_param2_means=None, group_param2_half_width=0.001,
                                axes=None, show_row_titles=True, set_axis_labels=True,
                                show_figure_legend=True, add_numeric_colorbar=False,
                                hue_norm=None, palette_numeric="viridis", figure_suptitle=True,
                                colorbar_rect=None, colorbar_orientation="horizontal", return_data=False,
                                return_params=False):
    """
    Plot ventilation model fits comparing modeled vs LES flux velocities.
    
    Parameters:
    -----------
    data : DataFrame
        Input data containing all required columns
    y_var : str
        Name of the dependent variable (LES flux)
    x_var : str
        Name of the primary independent variable (modeled flux)
    x_var2 : str, optional
        Name of secondary independent variable (e.g., turbulence intensity)
    hue : str
        Column name for color grouping in scatter plot
    style : str
        Column name for marker style in scatter plot
    model_func : callable
        Function to use for curve fitting
    model_name : str
        Name of the model for plot title
    p0 : list
        Initial parameter guesses for curve_fit
    bounds : tuple
        Parameter bounds for curve_fit
    adjustData : bool
        If True, adjust x_var based on fitted model; if False, plot regression lines
    show_assymptotes : bool
        If True, show asymptote lines in each subplot
    group_param2_means : dict, optional
        Optional mapping for second fit parameter initialization by subgroup, keyed by
        (skylight, Sdelp) where skylight is 0/1 (or False/True) and Sdelp is +/-1.
    group_param2_half_width : float, optional
        Half-width used to center the second parameter bounds around subgroup means
    axes : array-like of matplotlib axes, optional
        External axes for composition. Should contain two axes (Window, Skylight)
    show_row_titles : bool
        If True, title each row as Window/Skylight
    set_axis_labels : bool
        If True, set x/y labels for each subplot
    show_figure_legend : bool
        If True, add a figure-level legend for categorical hue/style
    add_numeric_colorbar : bool
        If True and hue is numeric, add a shared colorbar for these two subplots
    hue_norm : matplotlib.colors.Normalize, optional
        Normalization for numeric hue coloring
    palette_numeric : str
        Colormap for numeric hue
    figure_suptitle : bool
        If True, add a figure-level super title
    colorbar_orientation : str
        "horizontal" or "vertical" numeric colorbar orientation
    return_data : bool
        If True, return the (possibly adjusted) x_var series as a third return value
    return_params : bool
        If True, return a dict of fitted parameters keyed by (title, lbl), e.g.
        ("Window", "Flow Entering"), ("Window", "Flow Exiting"),
        ("Skylight", "Flow Entering"), ("Skylight", "Flow Exiting").
    
    Returns:
    --------
    fig, axs : matplotlib figure and axes objects
    """
    from scipy.optimize import curve_fit
    import seaborn as sns
    import numpy as np
    from matplotlib.colors import Normalize
    from matplotlib.cm import ScalarMappable

    data = data.copy()
    using_external_axes = axes is not None
    if using_external_axes:
        axs = np.array(axes).flatten()
        if len(axs) < 2:
            raise ValueError("When providing axes, pass at least two axes (Window, Skylight).")
        axs = axs[:2]
        fig = axs[0].figure
    else:
        n_rows = 1
        fig, axs = plt.subplots(n_rows, 2, figsize=(12, 6*n_rows), dpi=140, sharex=True, sharey=True)
        axs = np.array(axs).flatten()
    
    # Configure axes
    for i in range(len(axs)):
        axs[i].grid(True, alpha=0.3)
        axs[i].tick_params(labelsize=16)
        if set_axis_labels:
            axs[i].set_xlabel("Modeled Flux Velocity", fontsize=20)
            axs[i].set_ylabel("LES Flux Velocity", fontsize=20)
        axs[i].set_xlim(-0.6, 0.6)
        axs[i].set_ylim(-0.6, 0.6)
    
    hue_is_numeric = pd.api.types.is_numeric_dtype(data[hue])
    if hue_is_numeric and hue_norm is None:
        finite_vals = pd.to_numeric(data[hue], errors="coerce")
        finite_vals = finite_vals[np.isfinite(finite_vals)]
        if len(finite_vals) > 0:
            hue_norm = Normalize(vmin=finite_vals.min(), vmax=finite_vals.max())
    
    # Store asymptote legend info to re-apply after the removal loop
    asymptote_legend_handles = None
    asymptote_legend_labels = None
    scatter_collection_for_cbar = None
    fitted_params = {}

    # Plot for each skylight condition
    for i in range(2):
        sl_val = bool(i)
        plotdf = data[data["skylight"] == sl_val].copy()
        plotdf = plotdf.sort_values(by=[hue, style])
        
        min_val = min(plotdf[x_var].min(), plotdf[y_var].min())
        max_val = max(plotdf[x_var].max(), plotdf[y_var].max())
        
        # 1:1 reference line
        xs = np.array([min_val, max_val])
        axs[i].plot(xs, xs, 'r--', label='1:1 Line')
        
        # Title
        title = "Skylight" if sl_val else "Window"
        if show_row_titles:
            axs[i].set_title(title, fontsize=20)
        
        # Fit regression lines for each sign group (entering/exiting flow)
        for s, stl, lbl in [(1, '-', 'Flow Entering'), (-1, '-', 'Flow Exiting')]:
            regdf_cols = [x_var, y_var] + ([x_var2] if x_var2 else [])
            regdf = plotdf[plotdf["Sdelp"] == s][regdf_cols]
            regdf_abs = regdf.abs()
            regdf_abs = regdf_abs.sort_values(by=x_var)
            
            # Skip fit if subgroup has no samples
            if regdf_abs.empty:
                print(f"Skipping fit for {title}, {lbl}: no samples")
                continue
            
            # Build subgroup-specific fit initialization when requested
            fit_p0 = list(p0)
            fit_bounds = (list(bounds[0]), list(bounds[1]))
            if group_param2_means is not None and len(fit_p0) > 1:
                subgroup_keys = [
                    (int(sl_val), int(s)),
                    (bool(sl_val), int(s)),
                    (sl_val, s),
                ]
                subgroup_mean = None
                for key in subgroup_keys:
                    if key in group_param2_means:
                        subgroup_mean = group_param2_means[key]
                        break
                
                if subgroup_mean is not None and np.isfinite(subgroup_mean):
                    fit_p0[1] = float(subgroup_mean)
                    if len(fit_bounds[0]) > 1 and len(fit_bounds[1]) > 1:
                        fit_bounds[0][1] = float(subgroup_mean) - group_param2_half_width
                        fit_bounds[1][1] = float(subgroup_mean) + group_param2_half_width
                    print(
                        f"Init {title}, {lbl}: param2_mean={subgroup_mean:.4f}, "
                        f"bounds=({fit_bounds[0][1]:.4f}, {fit_bounds[1][1]:.4f})"
                    )
                else:
                    print(f"Init {title}, {lbl}: subgroup mean missing; using provided p0/bounds")
            
            # Fit model
            if x_var2:
                X_fit = (regdf_abs[x_var], regdf_abs[x_var2])
            else:
                X_fit = regdf_abs[x_var]
            
            popt = curve_fit(model_func, X_fit, regdf_abs[y_var], p0=fit_p0, bounds=fit_bounds)[0]
            print(f"Fitted parameters for {title}, {lbl}: popt={popt}")
            fitted_params[(title, lbl)] = popt
            
            mask = plotdf["Sdelp"] == s
            if x_var2:
                y_pred_model = model_func((np.abs(plotdf.loc[mask, x_var].values), np.abs(plotdf.loc[mask, x_var2].values)), *popt) * s
            else:
                y_pred_model = model_func(np.abs(plotdf.loc[mask, x_var].values), *popt) * s
            
            if adjustData:
                # Adjust x values based on fitted model
                plotdf.loc[mask, x_var] = y_pred_model
            else:
                # Plot regression line
                if x_var2:
                    y_pred = model_func((regdf_abs[x_var].values, regdf_abs[x_var2].values), *popt)
                else:
                    y_pred = model_func(regdf_abs[x_var], *popt)
                
                x_plot = regdf_abs[x_var] * s
                y_plot = y_pred * s
                
                fit_label = "Model" if s > 0 else None
                axs[i].plot(x_plot, y_plot, color="k", linestyle=stl, label=fit_label, linewidth=2.5)
                
                # Add asymptote plots if requested
                if show_assymptotes:
                    if x_var2:
                        y_pred_lower = s * model_func((regdf_abs[x_var].values, regdf_abs[x_var2].values), *popt, I_crit=0.001)
                        y_pred_upper = s * model_func((regdf_abs[x_var].values, regdf_abs[x_var2].values), *popt, I_crit=1000)
                    else:
                        y_pred_lower = s * model_func(regdf_abs[x_var], *popt, I_crit=0.001)
                        y_pred_upper = s * model_func(regdf_abs[x_var], *popt, I_crit=1000)
                    
                    upper_label = "Mean Dominated" if s > 0 else None
                    lower_label = "Fluctuation Dominated" if s > 0 else None
                    axs[i].plot(x_plot, y_pred_upper, color="blue", linestyle='--', label=upper_label, linewidth=1)
                    axs[i].plot(x_plot, y_pred_lower, color="green", linestyle='--', label=lower_label, linewidth=1)
            
            # Calculate model-vs-observed metrics
            y_obs_model = plotdf.loc[mask, y_var].values
            rmse, nrmse = calculate_normalized_rmse(
                y_obs_model,
                y_pred_model,
                normalization='std'
            )
            print(f"NRMSE: {nrmse:.2f}, RMSE: {rmse:.3f}")
            
            error = y_pred_model - y_obs_model
            print(f"Bias: {np.mean(error):.4f}, Error STD: {np.std(error):.4f}")

        
        # Scatter plot
        legend_mode = "auto"
        if hue_is_numeric:
            legend_mode = False
        scatter_ax = sns.scatterplot(
            data=plotdf, x=x_var, y=y_var,
            hue=hue, style=style,
            alpha=0.6, s=20, ax=axs[i],
            palette=palette_numeric if hue_is_numeric else "colorblind",
            hue_norm=hue_norm if hue_is_numeric else None,
            legend=legend_mode
        )
        if hue_is_numeric and len(scatter_ax.collections) > 0:
            scatter_collection_for_cbar = scatter_ax.collections[0]
            if scatter_collection_for_cbar is not None:
                scatter_collection_for_cbar.set_cmap(palette_numeric)
                if hue_norm is not None:
                    scatter_collection_for_cbar.set_norm(hue_norm)
        
        if adjustData:
            rmse, nrmse = calculate_normalized_rmse(plotdf[x_var], plotdf[y_var], normalization='std')
            print(f"For skylight={sl_val}, NRMSE: {nrmse:.4f}, RMSE: {rmse:.4f}")

        if return_data:
            data.loc[data["skylight"] == sl_val, x_var] = plotdf.loc[:, x_var]

    
    # Configure legends - collect from first axis and place at figure level
    handles, labels = axs[0].get_legend_handles_labels()
    for i in range(len(axs)):
        if axs[i].get_legend() is not None:
            axs[i].get_legend().remove()
    filtered = [(h, l) for h, l in zip(handles, labels) if l not in (None, '', '_nolegend_')]
    handles = [h for h, _ in filtered]
    labels = [l for _, l in filtered]
    
    if show_figure_legend and (not hue_is_numeric) and len(handles) > 0:
        if using_external_axes:
            fig.legend(handles, labels, loc='lower center', bbox_to_anchor=(0.5, -0.02),
                       fontsize=20, ncol=min(5, len(labels)), frameon=False)
        else:
            fig.legend(handles, labels, loc='center left', bbox_to_anchor=(0.93, 0.5),
                       fontsize=20, title='Room Type', title_fontsize=20)
    
    # Re-apply asymptote legend after removal loop (legacy behavior)
    if asymptote_legend_handles is not None and len(axs) > 2:
        axs[2].legend(asymptote_legend_handles, asymptote_legend_labels,
                      loc='upper left', fontsize=20)
    
    # Add numeric colorbar only when requested
    if add_numeric_colorbar and hue_is_numeric and scatter_collection_for_cbar is not None:
        colorbar_orientation = str(colorbar_orientation).lower()
        if colorbar_orientation not in ("horizontal", "vertical"):
            raise ValueError("colorbar_orientation must be 'horizontal' or 'vertical'.")
        if colorbar_rect is None:
            if colorbar_orientation == "vertical":
                colorbar_rect = (0.94, 0.15, 0.02, 0.7)
            else:
                colorbar_rect = (0.20, -0.03, 0.60, 0.03)
        cbar_ax = fig.add_axes(tuple(colorbar_rect))
        cbar_norm = hue_norm if hue_norm is not None else Normalize()
        cbar_mappable = ScalarMappable(norm=cbar_norm, cmap=palette_numeric)
        cbar_mappable.set_array([])
        cbar = fig.colorbar(cbar_mappable, cax=cbar_ax, orientation=colorbar_orientation)
        cbar.set_label(hue, fontsize=20)
        cbar.ax.tick_params(labelsize=20)
    
    if figure_suptitle:
        fig.suptitle(f"{model_name}: Modeled vs LES Flux with Sign-group Fits", fontsize=20)
    
    if not using_external_axes:
        plt.tight_layout(rect=[0, 0, 0.92, 0.95])
    
    if return_data and return_params:
        return fig, axs, data[x_var], fitted_params
    if return_data:
        return fig, axs, data[x_var]
    if return_params:
        return fig, axs, fitted_params
    return fig, axs

def calculate_normalized_rmse(y, y_pred, normalization='std'):
    """
    Calculate RMSE and normalized RMSE for any regression model.
    
    Parameters:
    -----------
    X : array-like, shape (n_samples, n_features)
        Input features
    y : array-like, shape (n_samples,)
        Target values
    normalization : str, optional (default='std')
        Method for normalization:
        - 'std': normalize by standard deviation of y
        - 'mean': normalize by mean of y
        - 'range': normalize by range of y
        
    Returns:
    --------
    rmse : float
        Root Mean Square Error
    nrmse : float
        Normalized Root Mean Square Error
    """
    import numpy as np
    
    # Calculate RMSE
    mse = np.mean((y - y_pred)**2)
    rmse = np.sqrt(mse)
    
    # Calculate normalized RMSE
    if normalization == 'mean':
        # Normalize by mean of observed values
        nrmse = rmse / np.mean(np.abs(y))
    elif normalization == 'range':
        # Normalize by range of observed values
        nrmse = rmse / (np.max(y) - np.min(y))
    else:  # default: 'std'
        # Normalize by standard deviation of observed values
        nrmse = rmse / np.std(y)
    
    return rmse, nrmse