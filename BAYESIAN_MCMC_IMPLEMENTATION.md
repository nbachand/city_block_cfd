# Bayesian MCMC Ventilation Notes

This note explains the Bayesian MCMC model currently implemented for the pressure-based ventilation fit and points to the code that implements each mathematical piece.

## Scope

The current workflow fits one Bayesian model per subgroup:

- `Window`, `Flow Entering`
- `Window`, `Flow Exiting`
- `Skylight`, `Flow Entering`
- `Skylight`, `Flow Exiting`

Those subgroup fits are orchestrated in [emulationHelpers.py](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L458); see `fit_bayesian_ventilation_p_subgroups(...)`.

## Forward Model

For one observation, the deterministic forward model is

\[
\mu_i = f(u_i; a, p_{\mathrm{rms}}) = \mathrm{ventilationReDecomp\_p}(u_i, a, p_{\mathrm{rms}})
\]

where:

- `u_i` is the modeled flux velocity input
- `a` is a multiplicative scale factor
- `p_rms` is the pressure fluctuation parameter

The underlying `pyafn` implementation is in [/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py](/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py):

- `ventilationReDecomp_p(...)`: [/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py#L127](/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py#L127)
- `uModelToI_p(...)`: [/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py#L106](/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py#L106)
- `getI_p(...)`: [/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py#L97](/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py#L97)
- `ventilationBlendedScaling_p(...)`: [/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py#L73](/home/groups/gorle/codes/pyAFN/pyafn/ventilation.py#L73)

The key returned quantity is

\[
f(u_i; a, p_{\mathrm{rms}}) = a \, u_i \, s(I_i)
\]

with

\[
I_i = \mathrm{uModelToI\_p}(u_i, p_{\mathrm{rms}})
\]

and `s(I_i)` the pressure-based blended scaling.

## Likelihood

For each subgroup, the observed LES flux is modeled as

\[
y_i \sim \mathcal{N}(\mu_i, \sigma_{\mathrm{obs}})
\]

where:

- `mu_i = ventilationReDecomp_p(u_i, a, p_rms)`
- `sigma_obs` is the standard deviation of the additive residual noise

This is implemented in [emulationHelpers.py#L161](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L161) to [emulationHelpers.py#L168](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L168).

## Priors

The current priors are:

\[
a \sim \mathrm{LogNormal}(0, \sigma_a)
\]

\[
p_{\mathrm{rms}} \sim \mathrm{HalfNormal}(\sigma_p)
\]

\[
\sigma_{\mathrm{obs}} \sim \mathrm{HalfNormal}(\sigma_\epsilon)
\]

Important interpretation:

- `a` uses a lognormal prior with `mu = 0`, so its prior median is `exp(0) = 1`
- `p_rms` remains positive via a half-normal prior
- `sigma_obs` remains positive via a half-normal prior

These priors are defined in [emulationHelpers.py#L163](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L163) to [emulationHelpers.py#L166](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L166).

Default prior scales are currently:

- `a_sigma = 0.5`
- `p_rms_sigma = 0.1`
- `obs_sigma = 0.1`

See [emulationHelpers.py#L141](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L141) to [emulationHelpers.py#L143](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L143).

## Posterior

For one subgroup, the posterior is

\[
p(a, p_{\mathrm{rms}}, \sigma_{\mathrm{obs}} \mid y, u)
\propto
p(y \mid a, p_{\mathrm{rms}}, \sigma_{\mathrm{obs}}, u)
\,
p(a)
\,
p(p_{\mathrm{rms}})
\,
p(\sigma_{\mathrm{obs}})
\]

This is the main object inferred by PyMC in `fit_bayesian_pressure_subgroup(...)`; see [emulationHelpers.py#L137](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L137).

## Sampler

Sampling uses PyMC's slice sampler:

\[
(a, p_{\mathrm{rms}}, \sigma_{\mathrm{obs}})^{(t)} \rightarrow (a, p_{\mathrm{rms}}, \sigma_{\mathrm{obs}})^{(t+1)}
\]

through `pm.Slice()`.

This is chosen because the forward model is wrapped as a Python op, so gradient-based samplers like NUTS are not currently used.

See:

- `ventilation_redecomp_p_op(...)`: [emulationHelpers.py#L15](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L15)
- `pm.Slice()`: [emulationHelpers.py#L175](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L175)

## Posterior Samples and Summaries

After sampling, posterior draws are unpacked into a DataFrame with three columns:

- `a`
- `p_rms`
- `sigma_obs`

See [emulationHelpers.py#L193](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L193) to [emulationHelpers.py#L200](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L200).

Median summaries are then computed in [emulationHelpers.py#L205](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L205) to [emulationHelpers.py#L210](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L210).

The combined subgroup summary table is assembled in [emulationHelpers.py#L267](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L267) to [emulationHelpers.py#L280](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L280).

## Posterior Predictive Curves

To draw the fitted bands shown on the plots:

1. select posterior draws of `a`, `p_rms`, and `sigma_obs`
2. evaluate `ventilationReDecomp_p(...)` on a plotting grid
3. optionally add Gaussian noise with standard deviation `sigma_obs`
4. compute quantiles across draws

Mathematically, for a plotting location `x`:

\[
\tilde{y}(x) = f(x; a^{(m)}, p_{\mathrm{rms}}^{(m)}) + \epsilon^{(m)}
\]

with

\[
\epsilon^{(m)} \sim \mathcal{N}(0, \sigma_{\mathrm{obs}}^{(m)})
\]

and the plotted band is the empirical quantile interval over `m`.

This is implemented in [emulationHelpers.py#L214](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L214) to [emulationHelpers.py#L263](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L263).

## Plotting

Two main plot paths exist:

- posterior predictive fit panels: [emulationHelpers.py#L505](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L505) to [emulationHelpers.py#L698](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L698)
- posterior parameter histograms: [emulationHelpers.py#L284](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L284) to [emulationHelpers.py#L376](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L376)

The parameter posterior plots are histograms/KDEs of MCMC draws, not prior PDFs and not fitted population distributions.

## Save/Load Cache

Saved results are written as:

- one NetCDF file per subgroup for the `InferenceData`
- `metadata.json`
- `summary.csv`

See:

- save: [emulationHelpers.py#L380](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L380) to [emulationHelpers.py#L416](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L416)
- load: [emulationHelpers.py#L420](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L420) to [emulationHelpers.py#L454](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationHelpers.py#L454)

The notebook currently uses a cache directory named:

- `mcmc_cache/pressure_scalar_posteriors_alpha_lognormal`

## Notebook Entry Point

The notebook cell that launches or reloads the scalar-posterior workflow lives in [emulationMCMC.ipynb](/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/emulationMCMC.ipynb). The important settings are:

- `a_sigma = 0.5`
- `p_rms_sigma = 0.1`
- `obs_sigma = 0.1`
- cached save/load behavior through `save_bayesian_ventilation_fit_results(...)` and `load_bayesian_ventilation_fit_results(...)`

## Conceptual Summary

The current model is the simpler direct-parameter Bayesian calibration model:

- one `a` per subgroup
- one `p_rms` per subgroup
- one `sigma_obs` per subgroup

It is not the earlier hierarchical population-distribution model. That older version inferred a distribution for `a` and `p_rms`; the current version infers direct posteriors for the scalar parameters themselves.
