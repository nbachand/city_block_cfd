#!/usr/bin/env python3
"""Re-read the extra-probe running averages one step before a stats reset, without rerunning getVentilationStats.py.

    python3 -I patch_ep_reset_steps.py            # dry run: self-test every window, write nothing
    python3 -I patch_ep_reset_steps.py --write    # back up and rewrite the affected flowStats CSVs

The extra probes record CharLES running averages (*_avg), and general_mods.hpp resets stats at steps
40000, 120000 and 160000 before that step's probes are written. Before 2981f35, getVentilationStats.py
read the extra probes at the window's stop step, so the windows ending at 120000 and 160000 hold a
one-step snapshot. Only the EP_* / EPR_* columns of probes/flowStats-<start>to<stop>.csv are affected;
the flux-probe statistics are time averages over start:stop-1 and are left as they are.

For each window this script rebuilds the extra-probe table the way getVentilationStats.py does (nameKey +
probe locations + the EP quantities at one step) and passes it to addWindowDetails, which recomputes
EP_mag, EP_vel_orientation, EP_normal, EP_shear, EPR_mag and EPR_vel_orientation. Checks per window:

1. the current CSV's EP values equal the probe row at the stop step (still a snapshot) or at stop-1
   (already fixed, skipped); anything else stops the script;
2. rebuilding from the stop step reproduces the current CSV exactly (the rebuild path is faithful);
3. rebuilding from stop-1 changes only EP_* / EPR_* columns.

--write copies each patched CSV to <name>.csv.snapshotEP before overwriting it. Afterwards rebuild
CHARLES/multiRuns/flowStatsMI.csv and roomVentilationMI.csv with readRunStats (config2_post-multiRun.ipynb),
which recomputes the -NormEP / -NormEPR columns, EPR_Ri and the room-level EP quantities.
"""

from __future__ import annotations

import argparse
import shutil
import sys
from pathlib import Path

import numpy as np
import pandas as pd

HOME = Path(__file__).resolve().parent
sys.path.insert(0, str(HOME))
from filloutVentilationStats import addWindowDetails  # noqa: E402

RUNS = {"config2": [46, 47, 48, 49, 53, 54, 55, 56, 61, 62, 63, 64],
        "config3": [16, 17, 18, 19, 21, 22, 23, 24, 29, 30, 31, 33]}
WINDOWS = [(40000, 120000), (120000, 160000)]  # windows that end at a stats reset
EP_QUANTS = ["comp(u_avg,0)", "comp(u_avg,1)", "comp(u_avg,2)", "mag(u)_avg", "p_avg", "D_avg", "S_avg", "T_avg"]


def is_ep_col(col):
    return col.startswith("EP_") or col.startswith("EPR_")


class ExtraProbes:
    def __init__(self, probes_dir: Path):
        pq = probes_dir / "probesOut_parquet"
        self.key = pd.read_csv(probes_dir / "locations/nameKey_extraProbe.txt", header=None)[0]
        self.data = {}
        for q in EP_QUANTS:
            d = pd.read_parquet(pq / f"extraProbe.{q}.parquet").reset_index(drop=True)
            assert d.shape[1] == len(self.key) + 3, f"{pq} {q}: {d.shape[1]} columns for {len(self.key)} probes"
            self.data[q] = d
        loc = pd.read_parquet(pq / "extraProbe.README.parquet").reset_index(drop=True)
        # restarts append the README again; keep one copy if the copies agree
        dedup = loc.drop_duplicates()
        assert not dedup["0"].duplicated().any(), f"{pq}: README copies disagree"
        loc = dedup.sort_values("0").reset_index(drop=True)
        assert (loc["0"].values == np.arange(len(self.key))).all(), f"{pq}: {len(loc)} locations for {len(self.key)} probes"
        self.locations = loc.iloc[:, 1:4].set_axis(["x", "y", "z"], axis="columns")

    def row(self, q, step):
        d = self.data[q]
        i = np.flatnonzero(d["0"].values == step)
        if len(i) != 1:
            raise RuntimeError(f"step {step} appears {len(i)} times in extraProbe.{q}")
        return d.iloc[i[0], 3:].values.astype(float)

    def table(self, step):
        """The extraProbe frame getVentilationStats.py passes to addWindowDetails, read at one step."""
        df = pd.DataFrame({q: self.row(q, step) for q in EP_QUANTS})
        ep = pd.concat([self.key.rename(0), self.locations, df], axis="columns").set_index(0)
        ep = ep.rename(columns=lambda c: f"EP_{c}")
        return ep.rename(index=lambda s: s.replace("extraProbe_", ""))


def rebuild(flow, ep_table):
    base = flow[[c for c in flow.columns if not is_ep_col(c)]].copy()
    new = addWindowDetails(base, extraProbe=ep_table)
    new["blockType"] = new["blockType"].fillna("B")
    return new.loc[flow.index, flow.columns]


def frames_equal(a, b):
    return a.round(12).equals(b.round(12)) or all(
        np.allclose(a[c], b[c], rtol=0, atol=1e-10, equal_nan=True) if pd.api.types.is_numeric_dtype(a[c])
        else a[c].equals(b[c]) for c in a.columns)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--write", action="store_true", help="back up and overwrite the affected CSVs")
    args = ap.parse_args()

    todo = []
    for config, Rs in RUNS.items():
        for R in Rs:
            probes_dir = HOME / f"CHARLES/{config}/R{R}/probes"
            eps = ExtraProbes(probes_dir)
            for start, stop in WINDOWS:
                path = probes_dir / f"flowStats-{start}to{stop}.csv"
                flow = pd.read_csv(path, index_col=0)
                cur = flow["EP_p_avg"].dropna()
                hits = [st for st in (stop, stop - 1)
                        if np.allclose(eps.table(st)["EP_p_avg"].reindex(cur.index), cur, rtol=0, atol=1e-12)]
                tag = f"{config} R{R} {start}-{stop}"
                if hits == [stop - 1]:
                    print(f"{tag}: already read at {stop - 1}, skipped")
                    continue
                if hits != [stop]:
                    sys.exit(f"{tag}: EP_p_avg matches neither step {stop} nor {stop - 1}; stopping")

                same = rebuild(flow, eps.table(stop))
                if not frames_equal(same, flow):
                    bad = [c for c in flow.columns if not frames_equal(same[[c]], flow[[c]])]
                    sys.exit(f"{tag}: rebuilding at step {stop} does not reproduce the CSV ({bad[:6]}); stopping")

                fixed = rebuild(flow, eps.table(stop - 1))
                changed = [c for c in flow.columns if not frames_equal(fixed[[c]], flow[[c]])]
                if any(not is_ep_col(c) for c in changed):
                    sys.exit(f"{tag}: non-EP columns changed: {[c for c in changed if not is_ep_col(c)]}; stopping")
                dp = (fixed["EP_p_avg"] - flow["EP_p_avg"]).abs().max()
                print(f"{tag}: self-test ok, {len(changed)} EP columns change, max |dEP_p_avg| = {dp:.3f}")
                todo.append((path, fixed))

    print(f"\n{len(todo)} windows to patch")
    if not args.write:
        print("dry run: nothing written (use --write)")
        return
    for path, fixed in todo:
        backup = path.with_name(path.name + ".snapshotEP")
        if not backup.exists():
            shutil.copy2(path, backup)
        fixed.to_csv(path)
        print(f"wrote {path.relative_to(HOME)} (original kept as {backup.name})")


if __name__ == "__main__":
    main()
