"""In-network C_d fits of config2_post-multiRun_flowModel.ipynb (cells 32, 34, 41, 43), runnable as Slurm jobs.

Each fit minimizes the WS-normalized RMSE between the network-model opening flow ("p-noInt_optp0-q_model",
driven by the matched pressure-only pressures "p_avg-noInt") and the measured flux, over the four
piecewise discharge coefficients [window in, window out, skylight in, skylight out], with Nelder-Mead.
The fits differ only in the fixed flow-fluctuation input:

    pBulk   sigma_dCp IN Bulk Measured:     pRMS = bulk measured means of p_rms-noInt   (cell 32)
    qBulk   sigma_qn  IN Bulk Measured:     qRMS = bulk measured means of rms-mass_flux (cell 34)
    pPoint  sigma_dCp IN Pointwise Measured: pRMS = each opening's p_rms-noInt          (cell 41)
    qPoint  sigma_qn  IN Pointwise Measured: qRMS = each opening's rms-mass_flux        (cell 43)

Inputs: the notebook's flowStatsMI and roomVentilationMI as they are just before the fits (export cell
before cell 32, written by export_inputs). The objective is the notebook's, with two changes that do not
alter its value: only the "optp0" network solve is run (the objective never reads "optp0Cd"), and the room
loop of flowEmulationUtils.update_flow_and_ventilation is split by run over worker processes (a room only
reads and writes its own run's openings).

With AVERAGE_REALIZATIONS (default) the RMSE, and the bulk measured means, are over the realization-averaged
flows of each condition, as the notebooks report them. The per-realization fits of 2026-11-06 are kept in
CHARLES/multiRuns/cdFits/perRealization/.

Usage: fit_cd.py (command line, see fit_cd.slurm); in the notebook, load_fit(name) returns the result.
"""
import json
import os
import time
from pathlib import Path

import numpy as np
import pandas as pd

HOME = Path(__file__).resolve().parent
RESULTS_DIR = HOME / "CHARLES/multiRuns/cdFits"  # small JSON results, kept in the repo
INPUTS = Path(os.environ.get("SCRATCH", "/tmp")) / "Cascade/city_block_cfd/cdFits/inputs.pkl"

FITS = {  # name: (notebook cell, RMS column set, how it is set, initial guess)
    "pBulk": dict(cell=32, rms="pRMS", source="p_rms-noInt", kind="bulk", ws_power=2,
                  x0=[0.646, 0.649, 0.665, 0.696]),
    "qBulk": dict(cell=34, rms="qRMS", source="rms-mass_flux", kind="bulk", ws_power=1,
                  x0=[0.667, 0.671, 0.687, 0.686]),
    "pPoint": dict(cell=41, rms="pRMS", source="p_rms-noInt", kind="point",
                   x0=[0.646, 0.649, 0.665, 0.696]),
    "qPoint": dict(cell=43, rms="qRMS", source="rms-mass_flux", kind="point",
                   x0=[0.667, 0.671, 0.687, 0.686]),
}


# Each window-only condition was simulated twice (e.g. config2 R46 and R53, same csId). The network runs per
# realization with that realization's own pressure-only pressures; the error is that of the modeled and
# measured flows averaged over the realizations of each condition, so every condition counts once. This is
# the error the notebooks report (emulationHelpers.average_realizations). False: every realization's rows.
AVERAGE_REALIZATIONS = True


def _condition_keys(df):
    """(condition, opening) of each row: condition = csId * 10 + V, as emulationHelpers.condition_ids."""
    run = np.asarray(df.index.get_level_values(0), dtype=int)
    return [df["csId"].to_numpy(dtype=int) * 10 + run % 10, df.index.get_level_values(1)]


def qRMSE(df, average=None):
    average = AVERAGE_REALIZATIONS if average is None else average
    diff = (df["p-noInt_optp0-q_model"] - df["flux"]) / df["WS"]  # WS is the same in both realizations
    if average:
        diff = diff.groupby(_condition_keys(df), sort=False).mean()
    return np.sqrt(np.mean(diff**2))


def bulk_measured_rms(df, rms_col, ws_power, average=None):
    """Notebook cell 31: subgroup means (window/skylight x flow in/out) of the WS-normalized measured RMS.
    With averaging, the means are over conditions: the RMS of the realizations in quadrature, and the flow
    direction from the sign of the realization-averaged network flow."""
    average = AVERAGE_REALIZATIONS if average is None else average
    norm_rms = df[rms_col] / df["WS"]**ws_power
    skylight = df["openingType"] == "skylight"
    q_model = df["p-noInt_optp0-q_model"]
    keep = ~((df["roomType"] == "single") & (df["slAll"] == False))  # same subset as readEmulationMI
    if average:
        cond = pd.DataFrame({"rms2": norm_rms**2, "q": q_model, "skylight": skylight, "keep": keep}).groupby(
            _condition_keys(df), sort=False).agg(rms2=("rms2", "mean"), q=("q", "mean"),
                                                 skylight=("skylight", "first"), keep=("keep", "first"))
        cond = cond[cond["keep"]]
        means = np.sqrt(cond["rms2"]).groupby([cond["skylight"], cond["q"] >= 0]).mean()
    else:
        flow_in = q_model >= 0
        means = norm_rms[keep].groupby([skylight[keep], flow_in[keep]]).mean()
    means.index.names = ["skylight", "flow in"]
    scale = df["WS"]**ws_power
    rms_in = skylight.map(lambda sl: means[(sl, True)]) * scale
    rms_out = skylight.map(lambda sl: means[(sl, False)]) * scale
    return pd.Series([[i, o] for i, o in zip(rms_in, rms_out)], index=df.index), means


def piecewise_Cd(params, openingType):
    """Notebook get_piecewise_params (cell 20): [C_d in, C_d out] of a window or skylight."""
    aWindowIn, aWindowOut, aSkylightIn, aSkylightOut = params
    if openingType in ("xwindow", "zwindow"):
        return [aWindowIn, aWindowOut]
    if openingType == "skylight":
        return [aSkylightIn, aSkylightOut]
    raise ValueError(f"unknown openingType {openingType!r}")


def fit_frame(flowStatsMI, name):
    """flowStatsMI with the fit's fixed pRMS or qRMS column (and neither of the other)."""
    f = FITS[name]
    df = flowStatsMI.drop(columns=["pRMS", "qRMS", "C_d"], errors="ignore")
    if f["kind"] == "bulk":
        df[f["rms"]], _ = bulk_measured_rms(df, f["source"], f["ws_power"])
    else:
        df[f["rms"]] = df.apply(lambda x: [x[f["source"]], x[f["source"]]], axis=1)
    return df


# ---- objective, with the room loop split by run over a process pool --------------------------------
_W = {}  # per-worker data: the fit's flowStatsMI and roomVentilationMI, split by run


def _init_worker(flow_chunks, room_chunks, Cd):
    os.environ["TQDM_DISABLE"] = "1"
    _W.update(flow=flow_chunks, room=room_chunks, Cd=Cd)


def _solve_chunk(args):
    k, C_d = args
    import flowEmulationUtils as feUtils
    flow = _W["flow"][k].copy()
    flow["C_d"] = pd.Series(C_d, index=flow.index, dtype=object)  # [C_d in, C_d out] per opening
    flow, _ = feUtils.update_flow_and_ventilation(
        flow, _W["room"][k], useDoors=True, tempStack=True, doorCd=[_W["Cd"], _W["Cd"]],
        checkAnalytical=False, pTypes={"p-noInt": "p_avg-noInt"}, optTypes=["optp0"])
    return k, flow["p-noInt_optp0-q_model"]


class Objective:
    def __init__(self, flowStatsMI, roomVentilationMI, Cd, workers=1, log=None):
        self.flow, self.room, self.Cd = flowStatsMI, roomVentilationMI, Cd
        runs = np.array(sorted(self.room.index.get_level_values(0).unique()))
        n = max(1, min(workers, len(runs)))
        groups = np.array_split(runs, n)
        frun, rrun = self.flow.index.get_level_values(0), self.room.index.get_level_values(0)
        self.flow_chunks = [self.flow[frun.isin(g)] for g in groups]
        self.room_chunks = [self.room[rrun.isin(g)] for g in groups]
        self.opening = [c["openingType"].to_numpy() for c in self.flow_chunks]
        self.pool = None
        if n > 1:
            import multiprocessing as mp
            self.pool = mp.get_context("fork").Pool(
                n, initializer=_init_worker, initargs=(self.flow_chunks, self.room_chunks, Cd))
        else:
            _init_worker(self.flow_chunks, self.room_chunks, Cd)
        self.log, self.nfev, self.t0 = log, 0, time.time()
        if log is not None and not Path(log).exists():
            Path(log).write_text("nfev,elapsed_s,a_window_in,a_window_out,a_skylight_in,a_skylight_out,rmse\n")

    def model_flow(self, params):
        jobs = [(k, [piecewise_Cd(params, o) for o in ops]) for k, ops in enumerate(self.opening)]
        mapper = self.pool.imap_unordered if self.pool is not None else map
        q = dict(mapper(_solve_chunk, jobs))
        return pd.concat([q[k] for k in range(len(jobs))]).reindex(self.flow.index)

    def __call__(self, params):
        df = self.flow.assign(**{"p-noInt_optp0-q_model": self.model_flow(params)})
        rmse = qRMSE(df)
        self.nfev += 1
        if self.log is not None:
            with open(self.log, "a") as fh:
                fh.write(f"{self.nfev},{time.time() - self.t0:.1f}," + ",".join(f"{p:.10g}" for p in params)
                         + f",{rmse:.10g}\n")
        print(f"eval {self.nfev:4d}  {time.time() - self.t0:8.1f} s  params {np.round(params, 5)}  RMSE {rmse:.8f}",
              flush=True)
        return rmse

    def close(self):
        if self.pool is not None:
            self.pool.close()
            self.pool.join()


# ---- inputs and results ---------------------------------------------------------------------------
def export_inputs(flowStatsMI, roomVentilationMI, Cd, path=INPUTS):
    """Notebook export cell: save the fits' inputs (the state just before cell 32)."""
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    pd.to_pickle(dict(flowStatsMI=flowStatsMI, roomVentilationMI=roomVentilationMI, Cd=Cd,
                      saved=time.strftime("%F %T")), path)
    print(f"Saved C_d fit inputs to {path} ({len(flowStatsMI)} openings, {len(roomVentilationMI)} rooms)")
    return path


def load_inputs(path=INPUTS):
    return pd.read_pickle(path)


def initial_simplex_from_log(log, n=4):
    """Resume: the best n + 1 distinct points of an earlier run's evaluation log."""
    ev = pd.read_csv(log).drop_duplicates(subset=["a_window_in", "a_window_out", "a_skylight_in", "a_skylight_out"])
    if len(ev) < n + 1:
        return None
    return ev.nsmallest(n + 1, "rmse").iloc[:, 2:2 + n].to_numpy()


def save_result(name, result, meta):
    RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    out = dict(fit=name, x=list(map(float, result.x)), fun=float(result.fun), nit=int(result.nit),
               nfev=int(result.nfev), success=bool(result.success), message=str(result.message),
               final_simplex=[list(map(float, v)) for v in result.final_simplex[0]],
               final_simplex_fun=list(map(float, result.final_simplex[1])), **meta)
    path = RESULTS_DIR / f"{name}.json"
    path.write_text(json.dumps(out, indent=1))
    return path


def load_fit(name):
    """A finished fit as a scipy-like result (attributes x, fun, nit, nfev, success, message, final_simplex)."""
    from scipy.optimize import OptimizeResult
    d = json.loads((RESULTS_DIR / f"{name}.json").read_text())
    d["x"] = np.array(d["x"])
    d["final_simplex"] = (np.array(d.pop("final_simplex")), np.array(d.pop("final_simplex_fun")))
    return OptimizeResult(d)
