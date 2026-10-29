#!/usr/bin/env python3
"""Create the matched pressure-only (no-interior) LES runs, R76-R99 in Cascade config2 and config3.

    python3 -I setup_matched_noint_runs.py            # dry run: print the plan
    python3 -I setup_matched_noint_runs.py --write    # create Oak run folders + scratch run folders

Each interior run gets two pressure-only twins (docs/handoff_les_pressure_ws_scaling.md,
"Matched pressure-only restarts"), interpolated from its own restart file without INIT / RESET_ALL,
so the step and time carry over and the twin starts correlated with the interior run:

    window   slot      start file          RESET_STATS at step   NSTEPS   averaging window
    ΔT 0     76 + i    result.00039000     42000                 120000   42k-119k
    ΔT 5     88 + i    result.00159000     162000                240000   162k-239k

i is the source's position in SOURCES. general_mods.hpp also resets stats at steps 40000 and
160000; RESET_STATS is absolute simulation time (time = step * dt in every source run). The
input and submit script are copied from the existing no-interior run with the same config, angle
and WS (TEMPLATE), and the submit header is the one used for config2 R82. Existing folders are
never overwritten.
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
from pathlib import Path

CHARLES = Path("/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/CHARLES")
SCRATCH = Path(os.environ["SCRATCH"]) / "Cascade/city_block_cfd/CHARLES"
# Interior source runs in slot order: families a, b, s (all skylights open). Value: (angle, WS).
SOURCES = {
    2: {46: (45, 2), 47: (45, 4), 48: (0, 2), 49: (0, 4), 53: (45, 2), 54: (45, 4), 55: (0, 2), 56: (0, 4),
        61: (45, 2), 62: (45, 4), 63: (0, 2), 64: (0, 4)},
    3: {16: (45, 2), 17: (0, 2), 18: (45, 4), 19: (0, 4), 21: (45, 2), 22: (45, 4), 23: (0, 2), 24: (0, 4),
        29: (45, 2), 30: (45, 4), 31: (0, 2), 33: (0, 4)},
}
TEMPLATE = {(2, 45, 2): 57, (2, 45, 4): 58, (2, 0, 2): 59, (2, 0, 4): 60,
            (3, 45, 2): 25, (3, 45, 4): 26, (3, 0, 2): 27, (3, 0, 4): 28}
MESH = {2: "STITCH/config2/7M-mesh-noInteriors.mles", 3: "STITCH/config3/13M-mesh-noInteriors.mles"}
DT = {2: 0.02, 4: 0.01}
WINDOWS = {"dT0": {"offset": 76, "start": 39000, "reset": 42000, "nsteps": 120000},
           "dT5": {"offset": 88, "start": 159000, "reset": 162000, "nsteps": 240000}}
# Sources whose restart files are read from scratch instead of Oak: the R48 rerun (started 2026-10-28)
# writes its snapshots to its scratch run folder. Its dT5 twin (R90) is created once result.00159000 exists.
SOURCE_DATA = {(2, 48): SCRATCH / "config2/R48/data"}
SKIP_SOURCES: set = set()
SLURM_HEADER = """#SBATCH -n 24
#SBATCH --mem-per-cpu=7G
#SBATCH --time=7-00:00:00
#SBATCH --partition=serc
#SBATCH --mail-type=ALL
#SBATCH --constraint=[CLASS:SH4_CBASE|CLASS:SH4_CPERF|CLASS:SH3_CBASE.1]
"""


def source_data(c: int, src: int) -> Path:
    return SOURCE_DATA.get((c, src), CHARLES / f"config{c}/R{src}/data")


def charles_in(template: str, c: int, src: int, win: str, ws: int) -> str:
    w = WINDOWS[win]
    dt = DT[ws]
    lines = template.splitlines(keepends=True)
    head = [l for l in lines[:4] if re.match(r"\s*#?\s*(RESTART|INTERP_FROM_RESTART|INIT|RESET_ALL)\b", l)]
    assert len(head) == 4, f"unexpected template header: {lines[:4]}"
    header = (
        f"RESTART = {CHARLES.parent / MESH[c]}\n"
        f"# Pressure-only twin of interior run config{c} R{src} ({win} window), started from its step-{w['start']}\n"
        f"# state so the two runs begin correlated. No INIT / RESET_ALL: the file's step and time are kept.\n"
        f"INTERP_FROM_RESTART {source_data(c, src)}/result.{w['start']:08d}.sles\n"
        "# INIT time = 0.0 step = 0 p=0 T=0 D=0 #u = 10.0 0.0 0.000001\n"
        "# RESET_ALL\n"
    )
    body = "".join(lines[4:])
    reset = (f"# Absolute simulation time = step {w['reset']} at dt {dt}. general_mods.hpp also resets stats at step "
             f"{w['start'] + 1000};\n# this later reset leaves 3000 steps after the interpolation for the exterior to "
             f"adjust and the controller's\n# restart kick to settle. Averaging window: {w['reset']}-{w['nsteps'] - 1000}"
             f" (read from result.{w['nsteps'] - 1000:08d}).\n"
             f"RESET_STATS TIME = {w['reset'] * dt:g}\n")
    body, n = re.subn(r"^# RESET_STATS TIME = 800\n", reset, body, count=1, flags=re.M)
    assert n == 1, "template RESET_STATS line not found"
    body, n = re.subn(r"^NSTEPS = \d+", f"NSTEPS = {w['nsteps']}", body, count=1, flags=re.M)
    assert n == 1, "template NSTEPS line not found"
    m = re.search(r"^TIMESTEP DT = ([.\d]+)", body, flags=re.M)
    assert m and abs(float(m.group(1)) - dt) < 1e-12, f"template dt {m and m.group(1)} != {dt}"
    assert "../" not in header + "".join(l for l in body.splitlines(keepends=True) if not l.lstrip().startswith("#")), \
        "relative path left in input"
    return header + body


def charles_slurm(template: str, c: int, R: int) -> str:
    out, n = re.subn(r"^#SBATCH (?!--job-name).*\n", "", template, flags=re.M)
    out = re.sub(r"^#SBATCH --job-name=.*$", f"#SBATCH --job-name=cc{c}_R{R}\n{SLURM_HEADER.rstrip()}", out,
                 count=1, flags=re.M)
    assert f'PARENT_DIR="Cascade/city_block_cfd/CHARLES/config{c}"' in out
    return out


def plan():
    for c, srcs in SOURCES.items():
        for i, (src, (a, ws)) in enumerate(srcs.items()):
            for win, w in WINDOWS.items():
                yield {"C": c, "R": w["offset"] + i, "src": src, "A": a, "WS": ws, "win": win,
                       "template": TEMPLATE[(c, a, ws)], "skip": (c, src) in SKIP_SOURCES}


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--write", action="store_true", help="create the folders (default: dry run)")
    args = ap.parse_args()
    print(f"{'run':>12} {'source':>7} {'A':>3} {'WS':>3} {'win':>4} {'start file':>16} {'template':>9}  status")
    for p in plan():
        c, R, src, win = p["C"], p["R"], p["src"], p["win"]
        oak, scr = CHARLES / f"config{c}/R{R}", SCRATCH / f"config{c}/R{R}"
        start = source_data(c, src) / f"result.{WINDOWS[win]['start']:08d}.sles"
        if p["skip"]:
            status = "skipped (source restart files not yet available)"
        elif oak.exists() or scr.exists():
            status = "exists, left untouched"
        elif not start.exists():
            status = f"MISSING {start}"
        else:
            status = "create" if not args.write else "created"
            if args.write:
                tdir = CHARLES / f"config{c}/R{p['template']}"
                oak.mkdir()
                (oak / "charles.in").write_text(charles_in((tdir / "charles.in").read_text(), c, src, win, p["WS"]))
                slurm = oak / "charles.slurm"
                slurm.write_text(charles_slurm((tdir / "charles.slurm").read_text(), c, R))
                slurm.chmod(0o770)
                for d in ("data", "Images", "probes/probesOut", "probes/locations"):
                    (scr / d).mkdir(parents=True)
                for f in (tdir / "probes/locations").iterdir():
                    if f.is_file():
                        shutil.copy2(f, scr / "probes/locations" / f.name)
                # The templates' extraProbe.txt (except config2 R57's) is a later 216-point layout, not the
                # 360-point one their runs used; use the verified copy (README parquet of R57-60 / R25-28).
                for name in ("extraProbe.txt", "nameKey_extraProbe.txt"):
                    shutil.copy2(CHARLES / f"config{c}/noInt_locations/{name}", scr / "probes/locations" / name)
        print(f"config{c} R{R:<3} R{src:<5} {p['A']:>3} {p['WS']:>3} {win:>4} {start.name:>16} R{p['template']:<8}  {status}")


if __name__ == "__main__":
    main()
