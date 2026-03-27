import pandas as pd
import numpy as np
from scipy.optimize import curve_fit
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
    """PyTensor wrapper around pyafn.ventilationReDecomp_p for PyMC models."""
    return np.asarray(
        pyafn.ventilationReDecomp_p(np.asarray(u_model, dtype=float), float(a), float(p_rms)),
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