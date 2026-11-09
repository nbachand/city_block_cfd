"""Run one in-network C_d fit of config2_post-multiRun_flowModel.ipynb with Nelder-Mead (see cdFits.py).

    python fit_cd.py pBulk|qBulk|pPoint|qPoint [--workers N] [--resume] [--check x1 x2 x3 x4]

Writes CHARLES/multiRuns/cdFits/<fit>.json (the result; load_fit in the notebook) and logs every
evaluation to CHARLES/multiRuns/cdFits/<fit>-evals.csv. --resume restarts Nelder-Mead from the best
points of that log (e.g. after a time-out). --check evaluates the objective once at the given C_d values
and exits (to compare with the notebook's RMSE).
"""
import argparse
import os
import time

from scipy.optimize import minimize

import cdFits


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("fit", choices=list(cdFits.FITS))
    ap.add_argument("--workers", type=int, default=int(os.environ.get("SLURM_CPUS_PER_TASK", 1)))
    ap.add_argument("--inputs", default=str(cdFits.INPUTS))
    ap.add_argument("--resume", action="store_true")
    ap.add_argument("--check", nargs=4, type=float, metavar="C_D")
    args = ap.parse_args()

    os.environ["TQDM_DISABLE"] = "1"
    inp = cdFits.load_inputs(args.inputs)
    fit = cdFits.FITS[args.fit]
    print(f"{args.fit} (notebook cell {fit['cell']}): inputs {args.inputs} saved {inp['saved']}, "
          f"{len(inp['flowStatsMI'])} openings, {len(inp['roomVentilationMI'])} rooms, {args.workers} workers, "
          f"average_realizations={cdFits.AVERAGE_REALIZATIONS}", flush=True)
    flow = cdFits.fit_frame(inp["flowStatsMI"], args.fit)
    cdFits.RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    log = None if args.check else cdFits.RESULTS_DIR / f"{args.fit}-evals.csv"
    if log is not None and log.exists() and not args.resume:
        log.rename(log.with_name(f"{log.stem}.{time.strftime('%Y%m%d-%H%M%S')}.csv"))  # keep the old log
    obj = cdFits.Objective(flow, inp["roomVentilationMI"], inp["Cd"], workers=args.workers, log=log)
    try:
        if args.check:
            obj(args.check)
            return
        options = {}
        if args.resume and log.exists():
            simplex = cdFits.initial_simplex_from_log(log)
            if simplex is not None:
                options["initial_simplex"] = simplex
                print(f"resuming from the best {len(simplex)} points of {log}", flush=True)
        t0 = time.time()
        result = minimize(obj, fit["x0"], method="Nelder-Mead", options=options)
        print(result, flush=True)
        path = cdFits.save_result(args.fit, result, dict(
            cell=fit["cell"], x0=fit["x0"], inputs=args.inputs, inputs_saved=inp["saved"],
            workers=args.workers, wall_s=round(time.time() - t0, 1), resumed=bool(options),
            average_realizations=cdFits.AVERAGE_REALIZATIONS,
            slurm_job=os.environ.get("SLURM_JOB_ID")))
        print(f"saved {path}", flush=True)
    finally:
        obj.close()


if __name__ == "__main__":
    main()
