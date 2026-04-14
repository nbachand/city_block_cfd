import pandas as pd
import numpy as np
from scipy.optimize import curve_fit
from scipy.stats import norm, probplot, shapiro
import seaborn as sns
from matplotlib.colors import Normalize
from matplotlib.cm import ScalarMappable
from matplotlib.lines import Line2D
import pyafn
from matplotlib import pyplot as plt
import pytensor.tensor as pt
from pytensor.compile.ops import wrap_py
from pyafn import rho, Cd



@wrap_py(itypes=[pt.dvector, pt.dscalar, pt.dscalar], otypes=[pt.dvector])
def ventilation_redecomp_p_op(u_model, a, p_rms):
    """PyTensor wrapper around pyafn.ventilationReDecomp_p for scalar subgroup parameters."""
    return np.asarray(
        pyafn.ventilationReDecomp_p(np.asarray(u_model, dtype=float), float(a), float(p_rms)),
        dtype=float,
    )


@wrap_py(itypes=[pt.dvector, pt.dscalar, pt.dscalar], otypes=[pt.dvector])
def ventilation_redecomp_q_op(u_model, a, q_rms):
    """PyTensor wrapper around pyafn.ventilationReDecomp_q for scalar subgroup parameters."""
    return np.asarray(
        pyafn.ventilationReDecomp_q(np.asarray(u_model, dtype=float), float(a), float(q_rms)),
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


def _summarize_parameter_draws(parameter_draws):
    summary = parameter_draws.describe(percentiles=[0.025, 0.5, 0.975]).T
    summary = summary.rename(
        columns={
            "50%": "median",
            "std": "sd",
            "2.5%": "hdi_2.5%",
            "97.5%": "hdi_97.5%",
        }
    )
    return summary[["mean", "sd", "hdi_2.5%", "median", "hdi_97.5%"]]



def fit_bayesian_pressure_subgroup(
    u_model,
    y_obs,
    *,
    a_mu=1.0,
    a_sigma=0.1,
    log_p_rms_mu=-3.0,
    log_p_rms_sigma=0.1,
    obs_sigma=0.01,
    random_seed=42,
    sample_kwargs=None,
):
    """Fit one a/p_rms/sigma_obs posterior for a single subgroup."""
    import pymc as pm

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
        a = pm.Normal("a", mu=a_mu, sigma=a_sigma)
        log_p_rms = pm.Normal("log_p_rms", mu=log_p_rms_mu, sigma=log_p_rms_sigma)
        p_rms = pm.Deterministic("p_rms", pt.exp(log_p_rms))
        sigma_obs = pm.HalfNormal("sigma_obs", sigma=obs_sigma)
        mu = ventilation_redecomp_p_op(u_model_data, a, p_rms)
        pm.Normal("y_like", mu=mu, sigma=sigma_obs, observed=y_obs)

        sample_kwargs_local.setdefault("draws", 1000)
        sample_kwargs_local.setdefault("tune", 1000)
        sample_kwargs_local.setdefault("chains", 4)
        sample_kwargs_local.setdefault("cores", 4)
        sample_kwargs_local.setdefault("progressbar", True)
        sample_kwargs_local.setdefault("step", pm.Slice())
        sample_kwargs_local.setdefault("random_seed", random_seed)

        idata = pm.sample(**sample_kwargs_local)

    parameter_draws = _parameter_draws_from_idata(idata)
    summary = _summarize_parameter_draws(parameter_draws)

    return {
        "idata": idata,
        "summary": summary,
        "parameter_draws": parameter_draws,
        "posterior_median": _posterior_median_from_parameter_draws(parameter_draws),
        "n_obs": len(u_model),
    }



def _parameter_draws_from_idata(idata):
    posterior = idata.posterior
    return pd.DataFrame(
        {
            "a": np.asarray(posterior["a"].values).reshape(-1),
            "p_rms": np.asarray(posterior["p_rms"].values).reshape(-1),
            "sigma_obs": np.asarray(posterior["sigma_obs"].values).reshape(-1),
        }
    )


def _parameter_draws_q_from_idata(idata):
    posterior = idata.posterior
    return pd.DataFrame(
        {
            "a": np.asarray(posterior["a"].values).reshape(-1),
            "q_rms": np.asarray(posterior["q_rms"].values).reshape(-1),
            "sigma_obs": np.asarray(posterior["sigma_obs"].values).reshape(-1),
        }
    )



def _posterior_median_from_parameter_draws_generic(parameter_draws, columns):
    return {column: float(np.median(parameter_draws[column])) for column in columns}


def _posterior_median_from_parameter_draws(parameter_draws):
    return _posterior_median_from_parameter_draws_generic(parameter_draws, ["a", "p_rms", "sigma_obs"])


def _posterior_median_from_parameter_draws_q(parameter_draws):
    return _posterior_median_from_parameter_draws_generic(parameter_draws, ["a", "q_rms", "sigma_obs"])


def fit_bayesian_q_subgroup(
    u_model,
    y_obs,
    *,
    a_mu=1.0,
    a_sigma=0.1,
    log_q_rms_mu=-2.0,
    log_q_rms_sigma=0.1,
    obs_sigma=0.01,
    random_seed=42,
    sample_kwargs=None,
):
    """Fit one a/q_rms/sigma_obs posterior for a single subgroup."""
    import pymc as pm

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
        a = pm.Normal("a", mu=a_mu, sigma=a_sigma)
        log_q_rms = pm.Normal("log_q_rms", mu=log_q_rms_mu, sigma=log_q_rms_sigma)
        q_rms = pm.Deterministic("q_rms", pt.exp(log_q_rms))
        sigma_obs = pm.HalfNormal("sigma_obs", sigma=obs_sigma)
        mu = ventilation_redecomp_q_op(u_model_data, a, q_rms)
        pm.Normal("y_like", mu=mu, sigma=sigma_obs, observed=y_obs)

        sample_kwargs_local.setdefault("draws", 1000)
        sample_kwargs_local.setdefault("tune", 1000)
        sample_kwargs_local.setdefault("chains", 4)
        sample_kwargs_local.setdefault("cores", 4)
        sample_kwargs_local.setdefault("progressbar", True)
        sample_kwargs_local.setdefault("step", pm.Slice())
        sample_kwargs_local.setdefault("random_seed", random_seed)

        idata = pm.sample(**sample_kwargs_local)

    parameter_draws = _parameter_draws_q_from_idata(idata)
    summary = _summarize_parameter_draws(parameter_draws)

    return {
        "idata": idata,
        "summary": summary,
        "parameter_draws": parameter_draws,
        "posterior_median": _posterior_median_from_parameter_draws_q(parameter_draws),
        "n_obs": len(u_model),
    }



def posterior_predict_bayesian_pressure_curve(
    fit_result,
    x_grid,
    *,
    sign=1,
    credible_interval=0.95,
    posterior_draws_for_curves=300,
    include_obs_noise=True,
    random_seed=42,
):
    """Generate posterior output bands from direct a/p_rms subgroup fits."""
    x_grid = np.asarray(x_grid, dtype=float)
    if x_grid.ndim != 1:
        raise ValueError("x_grid must be a 1D array.")
    if len(x_grid) == 0:
        raise ValueError("x_grid must contain at least one point.")

    parameter_draws = fit_result["parameter_draws"].reset_index(drop=True)
    if posterior_draws_for_curves is not None and len(parameter_draws) > posterior_draws_for_curves:
        idx = np.linspace(0, len(parameter_draws) - 1, posterior_draws_for_curves, dtype=int)
        parameter_draws = parameter_draws.iloc[idx].reset_index(drop=True)

    a_vals = parameter_draws["a"].to_numpy(dtype=float)
    p_vals = parameter_draws["p_rms"].to_numpy(dtype=float)
    sigma_vals = np.maximum(parameter_draws["sigma_obs"].to_numpy(dtype=float), 1e-8)

    target_shape = (len(parameter_draws), len(x_grid))
    x_eval = np.broadcast_to(x_grid[np.newaxis, :], target_shape)
    a_eval = np.broadcast_to(a_vals[:, np.newaxis], target_shape)
    p_eval = np.broadcast_to(p_vals[:, np.newaxis], target_shape)
    y_draws = np.asarray(pyafn.ventilationReDecomp_p(x_eval, a_eval, p_eval), dtype=float)

    if include_obs_noise:
        rng = np.random.default_rng(random_seed)
        y_draws = y_draws + rng.normal(loc=0.0, scale=sigma_vals[:, np.newaxis], size=y_draws.shape)

    y_draws = sign * y_draws
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


def posterior_predict_bayesian_q_curve(
    fit_result,
    x_grid,
    *,
    sign=1,
    credible_interval=0.95,
    posterior_draws_for_curves=300,
    include_obs_noise=True,
    random_seed=42,
):
    """Generate posterior output bands from direct a/q_rms subgroup fits."""
    x_grid = np.asarray(x_grid, dtype=float)
    if x_grid.ndim != 1:
        raise ValueError("x_grid must be a 1D array.")
    if len(x_grid) == 0:
        raise ValueError("x_grid must contain at least one point.")

    parameter_draws = fit_result["parameter_draws"].reset_index(drop=True)
    if posterior_draws_for_curves is not None and len(parameter_draws) > posterior_draws_for_curves:
        idx = np.linspace(0, len(parameter_draws) - 1, posterior_draws_for_curves, dtype=int)
        parameter_draws = parameter_draws.iloc[idx].reset_index(drop=True)

    a_vals = parameter_draws["a"].to_numpy(dtype=float)
    q_vals = parameter_draws["q_rms"].to_numpy(dtype=float)
    sigma_vals = np.maximum(parameter_draws["sigma_obs"].to_numpy(dtype=float), 1e-8)

    target_shape = (len(parameter_draws), len(x_grid))
    x_eval = np.broadcast_to(x_grid[np.newaxis, :], target_shape)
    a_eval = np.broadcast_to(a_vals[:, np.newaxis], target_shape)
    q_eval = np.broadcast_to(q_vals[:, np.newaxis], target_shape)
    y_draws = np.asarray(pyafn.ventilationReDecomp_q(x_eval, a_eval, q_eval), dtype=float)

    if include_obs_noise:
        rng = np.random.default_rng(random_seed)
        y_draws = y_draws + rng.normal(loc=0.0, scale=sigma_vals[:, np.newaxis], size=y_draws.shape)

    y_draws = sign * y_draws
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
        summary.insert(0, "n_obs", result.get("n_obs", np.nan))
        summary.insert(1, "direction", direction)
        summary.insert(1, "panel", title)
        rows.append(summary)

    if not rows:
        return pd.DataFrame(columns=["panel", "direction", "n_obs", "parameter"])
    return pd.concat(rows, ignore_index=True)



def summarize_bayesian_parameter_normal_fit_tests(fit_results, *, columns=None):
    """Run Shapiro-Wilk normality diagnostics for posterior parameters."""
    if columns is None:
        columns = ["a", "p_rms", "sigma_obs"]
    columns = list(columns)
    if len(columns) == 0:
        raise ValueError("columns must contain at least one parameter name.")

    preferred_order = [
        ("Window", "Flow Entering"),
        ("Window", "Flow Exiting"),
        ("Skylight", "Flow Entering"),
        ("Skylight", "Flow Exiting"),
    ]
    fit_keys = [key for key in preferred_order if key in fit_results]
    fit_keys.extend([key for key in fit_results if key not in fit_keys])

    rows = []
    for title, direction in fit_keys:
        result = fit_results[(title, direction)]
        draws = result["parameter_draws"]
        for column in columns:
            if column not in draws.columns:
                raise KeyError(f"Parameter column '{column}' not found in posterior draws.")
            vals = pd.to_numeric(draws[column], errors="coerce").to_numpy(dtype=float)
            vals = vals[np.isfinite(vals)]
            if len(vals) == 0:
                raise ValueError(f"Posterior column '{column}' has no finite values.")

            fit_mean = float(np.mean(vals))
            fit_sd = max(float(np.std(vals, ddof=0)), 1e-12)
            shapiro_result = shapiro(vals)
            rows.append(
                {
                    "panel": title,
                    "direction": direction,
                    "n_obs": result.get("n_obs", np.nan),
                    "n_draws": int(len(vals)),
                    "parameter": column,
                    "normal_fit_mean": fit_mean,
                    "normal_fit_sd": fit_sd,
                    "shapiro_w": float(shapiro_result.statistic),
                    "shapiro_pvalue": float(shapiro_result.pvalue),
                    "reject_normal_5pct": bool(shapiro_result.pvalue < 0.05),
                }
            )

    return pd.DataFrame(rows)


def plot_empirical_model_error_distribution(
    data,
    y_var,
    x_var,
    *,
    ax=None,
    plot_mode="hist1d",
    split_by_subgroup=False,
    show_split_marginals=False,
    bins=40,
    density=True,
    color="0.55",
    hist_alpha=0.7,
    line_color="k",
    cmap="magma",
    colorbar=True,
    colorbar_max=50,
    positive_hist_color="tab:blue",
    negative_hist_color="tab:orange",
    error_xlabel=None,
    ventilation_ylabel=None,
    positive_ylabel="Flow Entering",
    negative_ylabel="Flow Exiting",
    print_counts=False,
    title="Empirical Model Error Distribution",
):
    """Plot empirical model error diagnostics in 1D or 2D."""
    panel_title_fontsize = 24
    axis_label_fontsize = 24
    marginal_label_fontsize = 20
    tick_label_fontsize = 16
    colorbar_label_fontsize = 16

    def _compute_error_stats(df):
        y_vals = pd.to_numeric(df[y_var], errors="coerce").to_numpy(dtype=float)
        x_vals = pd.to_numeric(df[x_var], errors="coerce").to_numpy(dtype=float)
        valid = np.isfinite(y_vals) & np.isfinite(x_vals)
        error_vals = y_vals[valid] - x_vals[valid]
        ventilation_vals = y_vals[valid]
        if len(error_vals) == 0:
            return None
        mu_local, sigma_local = norm.fit(error_vals)
        sigma_local = max(float(sigma_local), 1e-12)
        return {
            "error": error_vals,
            "ventilation": ventilation_vals,
            "mu_hat": float(mu_local),
            "sigma_hat": float(sigma_local),
            "n": int(len(error_vals)),
        }

    def _draw_hist(axis, stats, panel_title):
        error_vals = stats["error"]
        sns.histplot(
            error_vals,
            bins=bins,
            stat="density" if density else "count",
            color=color,
            alpha=hist_alpha,
            edgecolor="white",
            ax=axis,
        )

        axis.axvline(stats["mu_hat"], color="black", linestyle="--", linewidth=1.8)
        axis.set_title(panel_title, fontsize=panel_title_fontsize)
        axis.set_xlabel(error_xlabel or f"Error = {y_var} - {x_var}", fontsize=axis_label_fontsize)
        axis.set_ylabel("Density" if density else "Count", fontsize=axis_label_fontsize)
        axis.tick_params(axis="both", labelsize=tick_label_fontsize)
        axis.grid(True, alpha=0.25)

    def _draw_hist2d(axis, stats, panel_title, x_edges, y_edges, norm_obj):
        hist = axis.hist2d(
            stats["error"],
            stats["ventilation"],
            bins=[x_edges, y_edges],
            cmap=cmap,
            norm=norm_obj,
            cmin=1,
        )
        axis.axvline(0.0, color="black", linestyle="-", linewidth=1.2, alpha=0.9)
        axis.axhline(0.0, color="black", linestyle="-", linewidth=1.2, alpha=0.9)
        axis.set_xlabel(error_xlabel or f"Error = {y_var} - {x_var}", fontsize=axis_label_fontsize)
        axis.set_ylabel(ventilation_ylabel or f"Observed Ventilation = {y_var}", fontsize=axis_label_fontsize)
        axis.tick_params(axis="both", labelsize=tick_label_fontsize)
        axis.grid(False)
        return hist

    def _print_count_summary(total_stats, stats_by_panel=None):
        if not print_counts:
            return
        total_n = 0 if total_stats is None else total_stats["n"]
        print(f"Total count: {total_n}")
        if stats_by_panel is None:
            return
        for panel_name, panel_stats in stats_by_panel.items():
            panel_n = 0 if panel_stats is None else panel_stats["n"]
            print(f"  {panel_name}: {panel_n}")

    if plot_mode not in {"hist1d", "hist2d"}:
        raise ValueError("plot_mode must be 'hist1d' or 'hist2d'.")

    if not split_by_subgroup and plot_mode == "hist1d":
        stats = _compute_error_stats(data)
        if stats is None:
            raise ValueError("No finite model-error values were found.")

        if ax is None:
            fig, ax = plt.subplots(figsize=(7, 4.5), dpi=140)
        else:
            fig = ax.figure

        _draw_hist(ax, stats, title)
        _print_count_summary(stats)
        return fig, ax, stats

    if not split_by_subgroup and plot_mode == "hist2d":
        stats = _compute_error_stats(data)
        if stats is None:
            raise ValueError("No finite model-error values were found.")

        if ax is None:
            fig, ax = plt.subplots(figsize=(7, 5.5), dpi=140)
        else:
            fig = ax.figure

        x_edges = np.linspace(stats["error"].min(), stats["error"].max(), bins + 1)
        y_edges = np.linspace(stats["ventilation"].min(), stats["ventilation"].max(), bins + 1)
        counts, _, _ = np.histogram2d(stats["error"], stats["ventilation"], bins=[x_edges, y_edges])
        vmax = max(float(colorbar_max), 1.0) if colorbar_max is not None else max(float(counts.max()), 1.0)
        norm_obj = Normalize(vmin=0, vmax=vmax)
        hist = _draw_hist2d(ax, stats, title, x_edges, y_edges, norm_obj)
        if colorbar:
            cbar = fig.colorbar(hist[3], ax=ax)
            cbar.set_label("Count")
        _print_count_summary(stats)
        return fig, ax, stats

    if plot_mode == "hist1d":
        subgroup_order = [
            ("Window", False, 1),
            ("Window", False, -1),
            ("Skylight", True, 1),
            ("Skylight", True, -1),
        ]

        if ax is None:
            fig, axs = plt.subplots(2, 2, figsize=(12, 8), dpi=140, sharex=False, sharey=False)
        else:
            axs = np.asarray(ax)
            if axs.shape != (2, 2):
                raise ValueError("When split_by_subgroup=True and plot_mode='hist1d', ax must be a 2x2 array of axes.")
            fig = axs.flat[0].figure

        stats_by_panel = {}
        for axis, (opening_label, skylight_value, sdelp_value) in zip(np.asarray(axs).flat, subgroup_order):
            direction_label = "Positive Sign" if sdelp_value > 0 else "Negative Sign"
            subset = data[(data["skylight"] == skylight_value) & (data["Sdelp"] == sdelp_value)]
            stats = _compute_error_stats(subset)
            panel_key = (opening_label, sdelp_value)
            stats_by_panel[panel_key] = stats

            if stats is None:
                axis.set_title(f"{opening_label}, {direction_label}", fontsize=panel_title_fontsize)
                axis.text(0.5, 0.5, "No finite data", ha="center", va="center", transform=axis.transAxes)
                axis.set_axis_off()
                continue

            _draw_hist(axis, stats, f"{opening_label}, {direction_label}")

        fig.tight_layout()
        total_stats = _compute_error_stats(data)
        labeled_panel_stats = {
            f"{opening_label}, {'Positive Sign' if sdelp_value > 0 else 'Negative Sign'}": panel_stats
            for (opening_label, sdelp_value), panel_stats in stats_by_panel.items()
        }
        _print_count_summary(total_stats, labeled_panel_stats)
        return fig, axs, stats_by_panel

    subgroup_order = [
        ("Window", False),
        ("Skylight", True),
    ]

    all_stats = []
    stats_by_panel = {}
    for opening_label, skylight_value in subgroup_order:
        subset = data[data["skylight"] == skylight_value]
        stats = _compute_error_stats(subset)
        stats_by_panel[opening_label] = stats
        if stats is not None:
            all_stats.append(stats)

    if not all_stats:
        raise ValueError("No finite model-error values were found.")

    all_error = np.concatenate([stats["error"] for stats in all_stats])
    all_ventilation = np.concatenate([stats["ventilation"] for stats in all_stats])
    x_edges = np.linspace(all_error.min(), all_error.max(), bins + 1)
    y_edges = np.linspace(all_ventilation.min(), all_ventilation.max(), bins + 1)

    max_count = 0.0
    for stats in all_stats:
        counts, _, _ = np.histogram2d(stats["error"], stats["ventilation"], bins=[x_edges, y_edges])
        max_count = max(max_count, float(counts.max()))
    vmax = max(float(colorbar_max), 1.0) if colorbar_max is not None else max(max_count, 1.0)
    norm_obj = Normalize(vmin=0, vmax=vmax)

    if show_split_marginals:
        if ax is not None:
            raise ValueError("Custom axes are not supported when show_split_marginals=True.")

        fig = plt.figure(figsize=(12, 8), dpi=140)
        gs = fig.add_gridspec(
            3,
            2,
            height_ratios=[1, 2, 1],
            hspace=0.08,
            wspace=0.12,
        )

        top_axes = []
        main_axes = []
        bottom_axes = []
        hist = None

        max_pos_count = 1
        max_neg_count = 1
        panel_histograms = {}
        for opening_label, _ in subgroup_order:
            stats = stats_by_panel[opening_label]
            if stats is None:
                panel_histograms[opening_label] = {
                    "positive_counts": np.zeros(len(x_edges) - 1, dtype=float),
                    "negative_counts": np.zeros(len(x_edges) - 1, dtype=float),
                }
                continue
            pos_error = stats["error"][stats["ventilation"] > 0]
            neg_error = stats["error"][stats["ventilation"] < 0]
            pos_counts, _ = np.histogram(pos_error, bins=x_edges)
            neg_counts, _ = np.histogram(neg_error, bins=x_edges)
            panel_histograms[opening_label] = {
                "positive_counts": pos_counts,
                "negative_counts": neg_counts,
            }
            max_pos_count = max(max_pos_count, int(pos_counts.max()) if len(pos_counts) else 1)
            max_neg_count = max(max_neg_count, int(neg_counts.max()) if len(neg_counts) else 1)

        bar_centers = 0.5 * (x_edges[:-1] + x_edges[1:])
        bar_widths = np.diff(x_edges)
        x_limits = (x_edges[0], x_edges[-1])

        for col_idx, (opening_label, _) in enumerate(subgroup_order):
            shared_main = main_axes[0] if main_axes else None
            ax_main = fig.add_subplot(gs[1, col_idx], sharex=shared_main)
            ax_top = fig.add_subplot(gs[0, col_idx], sharex=ax_main)
            ax_bottom = fig.add_subplot(gs[2, col_idx], sharex=ax_main)
            top_axes.append(ax_top)
            main_axes.append(ax_main)
            bottom_axes.append(ax_bottom)

            stats = stats_by_panel[opening_label]
            if stats is None:
                for axis in (ax_top, ax_main, ax_bottom):
                    axis.text(0.5, 0.5, "No finite data", ha="center", va="center", transform=axis.transAxes)
                    axis.set_axis_off()
                continue

            hist = _draw_hist2d(ax_main, stats, opening_label, x_edges, y_edges, norm_obj)
            hist_data = panel_histograms[opening_label]

            ax_top.bar(
                bar_centers,
                hist_data["positive_counts"],
                width=bar_widths,
                color=positive_hist_color,
                alpha=0.85,
                edgecolor="white",
                linewidth=0.4,
                align="center",
            )
            ax_top.set_ylim(0, max_pos_count * 1.08)
            ax_top.set_title(f"{opening_label}", fontsize=panel_title_fontsize)
            ax_top.set_ylabel(positive_ylabel, fontsize=marginal_label_fontsize)
            ax_top.axvline(stats["mu_hat"], color="black", linestyle="--", linewidth=1.8)
            ax_top.grid(True, axis="y", alpha=0.2)
            ax_top.tick_params(axis="x", labelbottom=False)
            ax_top.tick_params(axis="y", labelsize=tick_label_fontsize)
            ax_top.set_xlim(*x_limits)

            ax_bottom.bar(
                bar_centers,
                hist_data["negative_counts"],
                width=bar_widths,
                color=negative_hist_color,
                alpha=0.85,
                edgecolor="white",
                linewidth=0.4,
                align="center",
            )
            ax_bottom.set_ylim(max_neg_count * 1.08, 0)
            ax_bottom.set_ylabel(negative_ylabel, fontsize=marginal_label_fontsize)
            ax_bottom.axvline(stats["mu_hat"], color="black", linestyle="--", linewidth=1.8)
            ax_bottom.grid(True, axis="y", alpha=0.2)
            ax_bottom.set_xlabel(error_xlabel or f"Error = {y_var} - {x_var}", fontsize=axis_label_fontsize)
            ax_bottom.tick_params(axis="both", labelsize=tick_label_fontsize)
            ax_bottom.set_xlim(*x_limits)

            ax_main.set_xlabel("")
            ax_main.tick_params(axis="x", bottom=False, labelbottom=False)
            ax_main.set_xlim(*x_limits)
            if col_idx > 0:
                ax_top.set_ylabel("")
                ax_main.set_ylabel("")
                ax_bottom.set_ylabel("")

        if colorbar and hist is not None:
            fig.subplots_adjust(bottom=0.10, top=0.90, left=0.08, right=0.90)
            cbar_ax = fig.add_axes((0.92, 0.28, 0.02, 0.38))
            cbar = fig.colorbar(hist[3], cax=cbar_ax, orientation="vertical")
            cbar.set_label("Count", fontsize=colorbar_label_fontsize)
            cbar.ax.tick_params(labelsize=tick_label_fontsize)
        else:
            fig.tight_layout(rect=[0, 0, 1, 0.95])
        total_stats = _compute_error_stats(data)
        _print_count_summary(total_stats, stats_by_panel)
        return fig, np.asarray(main_axes), stats_by_panel

    if ax is None:
        fig, axs = plt.subplots(1, 2, figsize=(12, 5.5), dpi=140, sharex=True, sharey=True)
    else:
        axs = np.asarray(ax)
        if axs.shape != (2,):
            raise ValueError("When split_by_subgroup=True and plot_mode='hist2d', ax must be a length-2 array of axes.")
        fig = axs.flat[0].figure

    hist = None
    for axis, (opening_label, _) in zip(np.asarray(axs).flat, subgroup_order):
        stats = stats_by_panel[opening_label]
        if stats is None:
            axis.set_title(opening_label, fontsize=panel_title_fontsize)
            axis.text(0.5, 0.5, "No finite data", ha="center", va="center", transform=axis.transAxes)
            axis.set_axis_off()
            continue

        hist = _draw_hist2d(axis, stats, opening_label, x_edges, y_edges, norm_obj)

    if colorbar and hist is not None:
        fig.subplots_adjust(bottom=0.22, top=0.88, wspace=0.12)
        cbar_ax = fig.add_axes((0.18, 0.08, 0.64, 0.04))
        cbar = fig.colorbar(hist[3], cax=cbar_ax, orientation="horizontal")
        cbar.set_label("Count", fontsize=colorbar_label_fontsize)
        cbar.ax.tick_params(labelsize=tick_label_fontsize)
    else:
        fig.tight_layout(rect=[0, 0, 1, 0.95])
    total_stats = _compute_error_stats(data)
    _print_count_summary(total_stats, stats_by_panel)
    return fig, axs, stats_by_panel


def plot_bayesian_ventilation_parameter_posteriors(
    fit_results,
    *,
    columns=None,
    labels=None,
    bins=40,
    kde=True,
    overlay_normal=False,
    normal_line_color="tab:red",
    normal_linewidth=2.0,
    figsize=None,
    axes=None,
):
    """Plot posterior parameter distributions for each fitted ventilation subgroup."""
    panel_title_fontsize = 24
    axis_label_fontsize = 24
    row_label_fontsize = 20
    tick_label_fontsize = 16

    if columns is None:
        columns = ["a", "p_rms", "sigma_obs"]
    columns = list(columns)
    if len(columns) == 0:
        raise ValueError("columns must contain at least one parameter name.")

    default_labels = {
        "a": "alpha",
        "p_rms": "p_rms",
        "sigma_obs": "sigma",
    }
    label_map = dict(default_labels)
    if labels is not None:
        label_map.update(labels)

    preferred_order = [
        ("Window", "Flow Entering"),
        ("Window", "Flow Exiting"),
        ("Skylight", "Flow Entering"),
        ("Skylight", "Flow Exiting"),
    ]
    fit_keys = [key for key in preferred_order if key in fit_results]
    fit_keys.extend([key for key in fit_results if key not in fit_keys])
    if len(fit_keys) == 0:
        raise ValueError("fit_results is empty.")

    n_rows = len(fit_keys)
    n_cols = len(columns)
    if axes is None:
        if figsize is None:
            figsize = (4.0 * n_cols, 2.8 * n_rows)
        fig, axs = plt.subplots(
            n_rows,
            n_cols,
            figsize=figsize,
            dpi=140,
            squeeze=False,
            sharex="col",
        )
    else:
        axs = np.asarray(axes, dtype=object)
        if axs.ndim == 1:
            axs = axs.reshape(n_rows, n_cols)
        if axs.shape != (n_rows, n_cols):
            raise ValueError(f"axes must have shape {(n_rows, n_cols)}.")
        fig = axs.flat[0].figure

    for row_idx, key in enumerate(fit_keys):
        title, direction = key
        draws = fit_results[key]["parameter_draws"]
        for col_idx, column in enumerate(columns):
            ax = axs[row_idx, col_idx]
            if column not in draws.columns:
                raise KeyError(f"Parameter column '{column}' not found in posterior draws.")
            vals = pd.to_numeric(draws[column], errors="coerce")
            vals = vals[np.isfinite(vals)]
            if len(vals) == 0:
                raise ValueError(f"Posterior column '{column}' has no finite values.")

            sns.histplot(vals, bins=bins, kde=kde, stat="density", ax=ax, color="0.45")
            if overlay_normal:
                mean = float(np.mean(vals))
                sd = max(float(np.std(vals, ddof=0)), 1e-12)
                x_grid = np.linspace(vals.min(), vals.max(), 400)
                ax.plot(
                    x_grid,
                    norm.pdf(x_grid, loc=mean, scale=sd),
                    color=normal_line_color,
                    linewidth=normal_linewidth,
                )
            median = float(np.median(vals))
            lower = float(np.quantile(vals, 0.025))
            upper = float(np.quantile(vals, 0.975))
            ax.axvline(median, color="k", linestyle="--", linewidth=2)
            ax.axvspan(lower, upper, color="0.7", alpha=0.25)
            ax.grid(True, alpha=0.25)
            ax.tick_params(labelsize=tick_label_fontsize)

            if row_idx == 0:
                ax.set_title(label_map.get(column, column), fontsize=panel_title_fontsize)
            if col_idx == 0:
                ax.set_ylabel(f"{title}\n{direction}", fontsize=row_label_fontsize)
            else:
                ax.set_ylabel("")
            if row_idx == n_rows - 1:
                ax.set_xlabel(label_map.get(column, column), fontsize=axis_label_fontsize)
            else:
                ax.set_xlabel("")

    fig.tight_layout()
    return fig, axs


def plot_bayesian_ventilation_parameter_traces(
    fit_results,
    *,
    columns=None,
    labels=None,
    figsize=None,
    axes=None,
    linewidth=0.9,
    alpha=0.85,
    show_mean=True,
    mean_color="black",
    mean_linestyle="--",
    mean_linewidth=1.5,
):
    """Plot MCMC chain traces for each fitted ventilation subgroup."""
    panel_title_fontsize = 24
    axis_label_fontsize = 24
    row_label_fontsize = 20
    tick_label_fontsize = 16

    if columns is None:
        columns = ["a", "p_rms", "sigma_obs"]
    columns = list(columns)
    if len(columns) == 0:
        raise ValueError("columns must contain at least one parameter name.")

    default_labels = {
        "a": "alpha",
        "p_rms": "p_rms",
        "q_rms": "q_rms",
        "sigma_obs": "sigma",
    }
    label_map = dict(default_labels)
    if labels is not None:
        label_map.update(labels)

    preferred_order = [
        ("Window", "Flow Entering"),
        ("Window", "Flow Exiting"),
        ("Skylight", "Flow Entering"),
        ("Skylight", "Flow Exiting"),
    ]
    fit_keys = [key for key in preferred_order if key in fit_results]
    fit_keys.extend([key for key in fit_results if key not in fit_keys])
    if len(fit_keys) == 0:
        raise ValueError("fit_results is empty.")

    first_posterior = fit_results[fit_keys[0]]["idata"].posterior
    if "chain" not in first_posterior.dims or "draw" not in first_posterior.dims:
        raise ValueError("Posterior inference data must contain 'chain' and 'draw' dimensions.")
    n_chains = int(first_posterior.sizes["chain"])
    chain_colors = plt.rcParams["axes.prop_cycle"].by_key().get(
        "color",
        ["tab:blue", "tab:orange", "tab:green", "tab:red"],
    )

    n_rows = len(fit_keys)
    n_cols = len(columns)
    if axes is None:
        if figsize is None:
            figsize = (4.4 * n_cols, 2.8 * n_rows)
        fig, axs = plt.subplots(
            n_rows,
            n_cols,
            figsize=figsize,
            dpi=140,
            squeeze=False,
            sharex=True,
        )
    else:
        axs = np.asarray(axes, dtype=object)
        if axs.ndim == 1:
            axs = axs.reshape(n_rows, n_cols)
        if axs.shape != (n_rows, n_cols):
            raise ValueError(f"axes must have shape {(n_rows, n_cols)}.")
        fig = axs.flat[0].figure

    for row_idx, key in enumerate(fit_keys):
        title, direction = key
        posterior = fit_results[key]["idata"].posterior
        draw_idx = np.arange(int(posterior.sizes["draw"]))
        for col_idx, column in enumerate(columns):
            ax = axs[row_idx, col_idx]
            if column not in posterior.data_vars:
                raise KeyError(f"Parameter column '{column}' not found in posterior inference data.")

            values = np.asarray(posterior[column].values, dtype=float)
            if values.ndim != 2:
                raise ValueError(f"Posterior variable '{column}' must be a scalar parameter over chain and draw.")

            for chain_idx in range(values.shape[0]):
                ax.plot(
                    draw_idx,
                    values[chain_idx],
                    color=chain_colors[chain_idx % len(chain_colors)],
                    linewidth=linewidth,
                    alpha=alpha,
                )

            if show_mean:
                ax.axhline(
                    float(np.mean(values)),
                    color=mean_color,
                    linestyle=mean_linestyle,
                    linewidth=mean_linewidth,
                )

            ax.grid(True, alpha=0.25)
            ax.tick_params(labelsize=tick_label_fontsize)

            if row_idx == 0:
                ax.set_title(label_map.get(column, column), fontsize=panel_title_fontsize)
            if col_idx == 0:
                ax.set_ylabel(f"{title}\n{direction}", fontsize=row_label_fontsize)
            else:
                ax.set_ylabel("")
            if row_idx == n_rows - 1:
                ax.set_xlabel("Draw", fontsize=axis_label_fontsize)
            else:
                ax.set_xlabel("")

    legend_handles = [
        Line2D([0], [0], color=chain_colors[idx % len(chain_colors)], linewidth=1.8, label=f"Chain {idx + 1}")
        for idx in range(n_chains)
    ]
    if show_mean:
        legend_handles.append(
            Line2D([0], [0], color=mean_color, linestyle=mean_linestyle, linewidth=mean_linewidth, label="Posterior Mean")
        )
    fig.legend(
        handles=legend_handles,
        loc="upper center",
        bbox_to_anchor=(0.5, 1.01),
        ncol=min(len(legend_handles), 5),
        frameon=False,
        fontsize=14,
    )
    fig.tight_layout(rect=[0, 0, 1, 0.97])
    return fig, axs


def plot_bayesian_ventilation_parameter_qq(
    fit_results,
    *,
    columns=None,
    labels=None,
    figsize=None,
    axes=None,
    marker="o",
    marker_size=16,
    marker_alpha=0.7,
    point_color="0.35",
    line_color="tab:blue",
    line_width=2.0,
):
    """Plot normal Q-Q diagnostics for posterior parameter draws."""
    panel_title_fontsize = 24
    axis_label_fontsize = 24
    row_label_fontsize = 20
    tick_label_fontsize = 16

    if columns is None:
        columns = ["a", "p_rms", "sigma_obs"]
    columns = list(columns)
    if len(columns) == 0:
        raise ValueError("columns must contain at least one parameter name.")

    default_labels = {
        "a": "alpha",
        "p_rms": "p_rms",
        "q_rms": "q_rms",
        "sigma_obs": "sigma",
    }
    label_map = dict(default_labels)
    if labels is not None:
        label_map.update(labels)

    preferred_order = [
        ("Window", "Flow Entering"),
        ("Window", "Flow Exiting"),
        ("Skylight", "Flow Entering"),
        ("Skylight", "Flow Exiting"),
    ]
    fit_keys = [key for key in preferred_order if key in fit_results]
    fit_keys.extend([key for key in fit_results if key not in fit_keys])
    if len(fit_keys) == 0:
        raise ValueError("fit_results is empty.")

    n_rows = len(fit_keys)
    n_cols = len(columns)
    if axes is None:
        if figsize is None:
            figsize = (4.2 * n_cols, 3.2 * n_rows)
        fig, axs = plt.subplots(
            n_rows,
            n_cols,
            figsize=figsize,
            dpi=140,
            squeeze=False,
        )
    else:
        axs = np.asarray(axes, dtype=object)
        if axs.ndim == 1:
            axs = axs.reshape(n_rows, n_cols)
        if axs.shape != (n_rows, n_cols):
            raise ValueError(f"axes must have shape {(n_rows, n_cols)}.")
        fig = axs.flat[0].figure

    for row_idx, key in enumerate(fit_keys):
        title, direction = key
        draws = fit_results[key]["parameter_draws"]
        for col_idx, column in enumerate(columns):
            ax = axs[row_idx, col_idx]
            if column not in draws.columns:
                raise KeyError(f"Parameter column '{column}' not found in posterior draws.")
            vals = pd.to_numeric(draws[column], errors="coerce").to_numpy(dtype=float)
            vals = vals[np.isfinite(vals)]
            if len(vals) == 0:
                raise ValueError(f"Posterior column '{column}' has no finite values.")

            (theoretical_q, ordered_vals), (slope, intercept, _) = probplot(vals, dist="norm", fit=True)
            ax.scatter(
                theoretical_q,
                ordered_vals,
                s=marker_size,
                alpha=marker_alpha,
                color=point_color,
                marker=marker,
            )
            x_line = np.array([np.min(theoretical_q), np.max(theoretical_q)], dtype=float)
            ax.plot(
                x_line,
                slope * x_line + intercept,
                color=line_color,
                linewidth=line_width,
            )
            ax.grid(True, alpha=0.25)
            ax.tick_params(labelsize=tick_label_fontsize)

            if row_idx == 0:
                ax.set_title(label_map.get(column, column), fontsize=panel_title_fontsize)
            if col_idx == 0:
                ax.set_ylabel(f"{title}\n{direction}", fontsize=row_label_fontsize)
            else:
                ax.set_ylabel("")
            if row_idx == n_rows - 1:
                ax.set_xlabel("Normal Quantiles", fontsize=axis_label_fontsize)
            else:
                ax.set_xlabel("")

    fig.tight_layout()
    return fig, axs


def save_bayesian_ventilation_fit_results(fit_results, output_dir):
    """Save Bayesian subgroup MCMC results to disk using NetCDF plus JSON metadata."""
    import json
    from pathlib import Path

    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    metadata = {"format_version": 2, "entries": []}
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
        idata = az.from_netcdf(output_dir / entry["idata_file"])
        parameter_draws = _parameter_draws_from_idata(idata)
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
            "posterior_median": _posterior_median_from_parameter_draws(parameter_draws),
            "n_obs": int(entry.get("n_obs", len(subgroup["u_model"]))),
            "sign": int(entry.get("sign", 1)),
            "subgroup": subgroup,
        }

    return fit_results


def load_bayesian_q_ventilation_fit_results(output_dir):
    """Load saved q-side Bayesian subgroup MCMC results from NetCDF plus JSON metadata."""
    import json
    from pathlib import Path
    import arviz as az

    output_dir = Path(output_dir)
    metadata = json.loads((output_dir / "metadata.json").read_text())
    fit_results = {}

    for entry in metadata.get("entries", []):
        title = entry["panel"]
        direction = entry["direction"]
        idata = az.from_netcdf(output_dir / entry["idata_file"])
        parameter_draws = _parameter_draws_q_from_idata(idata)
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
            "posterior_median": _posterior_median_from_parameter_draws_q(parameter_draws),
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
    p_rms_var="p_rms-noInt-Norm",
    a_mu=1.0,
    a_sigma=0.1,
    obs_sigma=0.01,
    sample_kwargs=None,
    random_seed=42,
):
    """Fit one a/p_rms/sigma_obs posterior per Window/Skylight and Entering/Exiting subgroup."""
    fit_results = {}
    for i in range(2):
        sl_val = bool(i)
        title = "Skylight" if sl_val else "Window"
        plotdf = data[data["skylight"] == sl_val].copy()
        for j, (s, lbl) in enumerate([(1, "Flow Entering"), (-1, "Flow Exiting")]):
            subgroup = prepare_bayesian_ventilation_subgroup(data, y_var, x_var, sl_val, s)
            regdf_abs = subgroup["fitdf_abs"]
            if regdf_abs.empty:
                print(f"Skipping Bayesian fit for {title}, {lbl}: no samples")
                continue

            p_subset = pd.to_numeric(plotdf.loc[plotdf["Sdelp"] == int(s), p_rms_var], errors="coerce")

            log_p_subset = np.log(p_subset)
            log_p_rms_mu = float(np.mean(log_p_subset))
            log_p_rms_sigma = max(float(np.std(log_p_subset, ddof=0)), 1e-6)

            fit_result = fit_bayesian_pressure_subgroup(
                subgroup["u_model"],
                subgroup["y_obs"],
                a_mu=a_mu,
                a_sigma=a_sigma,
                log_p_rms_mu=log_p_rms_mu,
                log_p_rms_sigma=log_p_rms_sigma,
                obs_sigma=obs_sigma,
                random_seed=random_seed + i * 10 + j,
                sample_kwargs=sample_kwargs,
            )

            fit_result["subgroup"] = subgroup
            fit_result["sign"] = s
            fit_result["log_p_rms_prior_mu"] = log_p_rms_mu
            fit_result["log_p_rms_prior_sigma"] = log_p_rms_sigma
            fit_results[(title, lbl)] = fit_result

            med = fit_result["posterior_median"]
            print(
                f"Bayesian fit {title}, {lbl}: "
                f"a={med['a']:.4f}, p_rms={med['p_rms']:.4f}, sigma_obs={med['sigma_obs']:.4f}"
            )

    return fit_results


def fit_bayesian_ventilation_q_subgroups(
    data,
    y_var,
    x_var,
    *,
    q_rms_var="rms-mass_flux-Norm",
    a_mu=1.0,
    a_sigma=0.1,
    obs_sigma=0.01,
    sample_kwargs=None,
    random_seed=42,
):
    """Fit one a/q_rms/sigma_obs posterior per Window/Skylight and Entering/Exiting subgroup."""
    fit_results = {}
    for i in range(2):
        sl_val = bool(i)
        title = "Skylight" if sl_val else "Window"
        plotdf = data[data["skylight"] == sl_val].copy()
        for j, (s, lbl) in enumerate([(1, "Flow Entering"), (-1, "Flow Exiting")]):
            subgroup = prepare_bayesian_ventilation_subgroup(data, y_var, x_var, sl_val, s)
            regdf_abs = subgroup["fitdf_abs"]
            if regdf_abs.empty:
                print(f"Skipping Bayesian q fit for {title}, {lbl}: no samples")
                continue

            q_subset = pd.to_numeric(plotdf.loc[plotdf["Sdelp"] == int(s), q_rms_var], errors="coerce")
            q_subset = q_subset[np.isfinite(q_subset)]
            q_subset = q_subset[q_subset > 0]
            if len(q_subset) == 0:
                print(f"Skipping Bayesian q fit for {title}, {lbl}: no positive finite {q_rms_var} values")
                continue

            log_q_subset = np.log(q_subset)
            log_q_rms_mu = float(np.mean(log_q_subset))
            log_q_rms_sigma = max(float(np.std(log_q_subset, ddof=0)), 1e-6)

            fit_result = fit_bayesian_q_subgroup(
                subgroup["u_model"],
                subgroup["y_obs"],
                a_mu=a_mu,
                a_sigma=a_sigma,
                log_q_rms_mu=log_q_rms_mu,
                log_q_rms_sigma=log_q_rms_sigma,
                obs_sigma=obs_sigma,
                random_seed=random_seed + i * 10 + j,
                sample_kwargs=sample_kwargs,
            )

            fit_result["subgroup"] = subgroup
            fit_result["sign"] = s
            fit_result["log_q_rms_prior_mu"] = log_q_rms_mu
            fit_result["log_q_rms_prior_sigma"] = log_q_rms_sigma
            fit_results[(title, lbl)] = fit_result

            med = fit_result["posterior_median"]
            print(
                f"Bayesian q fit {title}, {lbl}: "
                f"a={med['a']:.4f}, q_rms={med['q_rms']:.4f}, sigma_obs={med['sigma_obs']:.4f}"
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
    colorbar_label=None,
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
    room_type_hue_order = ["cross", "corner", "dual", "single"] if hue == "roomType" else None
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
                include_obs_noise=include_obs_noise,
                random_seed=random_seed + 1000 + i * 10 + j,
            )
            fit_result["curve"] = curve

            band_name = "Posterior Predictive Band" if include_obs_noise else "Parameter Band"
            band_label = f"{int(credible_interval * 100)}% {band_name}" if s > 0 else None
            line_label = "Posterior Median Model" if s > 0 else None
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
                hue_order=None if hue_is_numeric else room_type_hue_order,
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
        cbar.set_label(colorbar_label or hue, fontsize=20)
        cbar.ax.tick_params(labelsize=20)

    if figure_suptitle:
        fig.suptitle(f"{model_name}: Direct Posterior Bands", fontsize=20)

    if not using_external_axes:
        plt.tight_layout(rect=[0, 0, 0.92, 0.95])

    return fig, axs


def plot_bayesian_ventilation_q_fit_results(
    data,
    fit_results,
    y_var,
    x_var,
    *,
    hue="roomType",
    style="slAll",
    model_name="Bayesian q_rms Ventilation Model",
    credible_interval=0.95,
    posterior_draws_for_curves=300,
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
    colorbar_label=None,
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
    """Plot previously-fitted Bayesian q_rms ventilation subgroup results."""
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
    room_type_hue_order = ["cross", "corner", "dual", "single"] if hue == "roomType" else None
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
            curve = posterior_predict_bayesian_q_curve(
                fit_result,
                x_grid,
                sign=s,
                credible_interval=credible_interval,
                posterior_draws_for_curves=posterior_draws_for_curves,
                include_obs_noise=include_obs_noise,
                random_seed=random_seed + 1000 + i * 10 + j,
            )
            fit_result["curve"] = curve

            band_name = "Posterior Predictive Band" if include_obs_noise else "Parameter Band"
            band_label = f"{int(credible_interval * 100)}% {band_name}" if s > 0 else None
            line_label = "Posterior Median Model" if s > 0 else None
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
                hue_order=None if hue_is_numeric else room_type_hue_order,
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
        cbar.set_label(colorbar_label or hue, fontsize=20)
        cbar.ax.tick_params(labelsize=20)

    if figure_suptitle:
        fig.suptitle(f"{model_name}: Direct Posterior Bands", fontsize=20)

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
    credible_interval=0.95,
    p_rms_var="p_rms-noInt-Norm",
    a_mu=1.0,
    a_sigma=0.1,
    obs_sigma=0.01,
    sample_kwargs=None,
    random_seed=42,
    posterior_draws_for_curves=300,
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
    colorbar_label=None,
    xlim=(-0.6, 0.6),
    ylim=(-0.6, 0.6),
    band_alpha=0.3,
    band_color="0.5",
    band_zorder=1,
    line_zorder=2,
    scatter_zorder=3,
    return_fits=False,
):
    """Fit Bayesian ventilation subgroups and plot the resulting direct-parameter bands."""
    fit_results = fit_bayesian_ventilation_p_subgroups(
        data,
        y_var,
        x_var,
        p_rms_var=p_rms_var,
        a_mu=a_mu,
        a_sigma=a_sigma,
        obs_sigma=obs_sigma,
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
        colorbar_label=colorbar_label,
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
                                colorbar_rect=None, colorbar_orientation="horizontal", colorbar_label=None, return_data=False,
                                return_params=False, return_metrics=False):
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
    colorbar_label : str, optional
        Label for the numeric colorbar. Defaults to the hue column name.
    return_data : bool
        If True, return the (possibly adjusted) x_var series as a third return value
    return_params : bool
        If True, return a dict of fitted parameters keyed by (title, lbl), e.g.
        ("Window", "Flow Entering"), ("Window", "Flow Exiting"),
        ("Skylight", "Flow Entering"), ("Skylight", "Flow Exiting").
    return_metrics : bool
        If True, return a tidy dataframe with subgroup- and opening-level error metrics.
    
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
    room_type_hue_order = ["cross", "corner", "dual", "single"] if hue == "roomType" else None
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
    metrics_rows = []

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
            print(f"$C_d$ is {Cd * popt[0]:.2f}, $\sigma$ is {popt[1]:.2f}")
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
            metrics_rows.append(
                {
                    "model_name": model_name,
                    "scope": "subgroup",
                    "opening_group": title,
                    "direction": lbl,
                    "split": f"{title}, {lbl}",
                    "adjusted": adjustData,
                    "x_label": x_var,
                    "y_label": y_var,
                    "cd": Cd * popt[0],
                    "sigma": popt[1] if len(popt) > 1 else np.nan,
                    "rmse": rmse,
                    "nrmse": nrmse,
                    "bias": np.mean(error),
                    "std": np.std(error),
                    "n": len(y_obs_model),
                }
            )

        
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
            hue_order=None if hue_is_numeric else room_type_hue_order,
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
            opening_error = plotdf[x_var] - plotdf[y_var]
            metrics_rows.append(
                {
                    "model_name": model_name,
                    "scope": "opening_total",
                    "opening_group": title,
                    "direction": "All",
                    "split": f"{title}, All",
                    "adjusted": adjustData,
                    "x_label": x_var,
                    "y_label": y_var,
                    "cd": np.nan,
                    "sigma": np.nan,
                    "rmse": rmse,
                    "nrmse": nrmse,
                    "bias": np.mean(opening_error),
                    "std": np.std(opening_error),
                    "n": len(plotdf[[x_var, y_var]].dropna()),
                }
            )

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
        cbar.set_label(colorbar_label or hue, fontsize=20)
        cbar.ax.tick_params(labelsize=20)
    
    if figure_suptitle:
        fig.suptitle(f"{model_name}: Modeled vs LES Flux with Sign-group Fits", fontsize=20)
    
    if not using_external_axes:
        plt.tight_layout(rect=[0, 0, 0.92, 0.95])

    metrics_df = pd.DataFrame(metrics_rows)
    
    if return_data and return_params and return_metrics:
        return fig, axs, data[x_var], fitted_params, metrics_df
    if return_data and return_params:
        return fig, axs, data[x_var], fitted_params
    if return_data and return_metrics:
        return fig, axs, data[x_var], metrics_df
    if return_params and return_metrics:
        return fig, axs, fitted_params, metrics_df
    if return_data:
        return fig, axs, data[x_var]
    if return_params:
        return fig, axs, fitted_params
    if return_metrics:
        return fig, axs, metrics_df
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
