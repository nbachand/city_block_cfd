#!/usr/bin/env python3
"""Turn the matched pressure-only runs' window-end POST output into the per-run opening stats that the
flow model reads, in the same format as the old pressure-only runs' (e.g. config2 R59).

    python process_matched_noint_posts.py --dry-run          # list what would be processed
    python process_matched_noint_posts.py [2|3] [--runs 82 94] [--overwrite]

Run from this folder with the pycascade environment (it imports ./pyCascade). For each matched run
R76-R99 (setup_matched_noint_runs.py) whose POST pass at the window-end step has finished:

 1. its opening point clouds, $SCRATCH/.../R<R>/post/<step>/probes/probesOut/<opening>.<step>.pcd and
    .pxyz, are converted to CHARLES/config<C>/R<R>/probes/probesOut_parquet/;
 2. its extra probes ($SCRATCH/.../R<R>/probes/probesOut/extraProbe.*, ~3 GB of text per run) are
    converted for every 1000th step of the averaging window only (rows of steps written twice by a
    restart are kept; pyCascade keeps the last), so the Oak copy stays small;
 3. nameKey_extraProbe.txt is copied from CHARLES/config<C>/noInt_locations/ to .../R<R>/probes/locations/;
 4. getVentilationStats.py config<C> <R> POINTCLOUD_PROBES <reset> <post> writes
    CHARLES/config<C>/R<R>/probes/flowStats-<reset>to<post>.csv, with its log in getVentilationStats-<post>.out.

A run is skipped if it already has that csv (unless --overwrite), if its POST job is still queued or
running, or if its POST output is incomplete.
"""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

CB = Path(__file__).resolve().parent
sys.path.insert(0, str(CB))
from setup_matched_noint_runs import CHARLES, SCRATCH, SOURCES, WINDOWS  # noqa: E402

N_OPENINGS = 336


def twins():
    for c, srcs in SOURCES.items():
        for i, src in enumerate(srcs):
            for w in WINDOWS.values():
                yield c, w["offset"] + i, src, w


def queued_jobs() -> set:
    out = subprocess.run(["squeue", "--me", "-h", "-o", "%j"], capture_output=True, text=True, check=True)
    return set(out.stdout.split())


def status(c, R, w, overwrite, queued):
    post = SCRATCH / f"config{c}/R{R}/post/{w['post']:08d}/probes/probesOut"
    csv = CHARLES / f"config{c}/R{R}/probes/flowStats-{w['reset']}to{w['post']}.csv"
    if csv.exists() and not overwrite:
        return "done", post, csv
    if f"post{c}_R{R}" in queued:
        return "POST still queued or running", post, csv
    if not post.is_dir():
        return "no POST output", post, csv
    n_pcd = len(list(post.glob(f"*.{w['post']:08d}.pcd")))
    n_pxyz = len(list(post.glob("*.pxyz")))
    if (n_pcd, n_pxyz) != (N_OPENINGS, N_OPENINGS):
        return f"POST output incomplete ({n_pcd} pcd, {n_pxyz} pxyz)", post, csv
    return "process", post, csv


def stage_extra_probes(src: Path, stage: Path, steps: set):
    """Copy extraProbe.* keeping the comment lines and the rows of the requested steps, trailing blanks stripped."""
    names = sorted(src.glob("extraProbe.*"))
    assert any(n.name == "extraProbe.README" for n in names) and len(names) > 1, f"no extra probes in {src}"
    for f in names:
        with open(f) as fin, open(stage / f.name, "w") as fout:
            for line in fin:
                if f.name.endswith(".README") or line.startswith("#"):
                    fout.write(line.rstrip() + "\n")
                    continue
                step = line.split(" ", 1)[0]
                if step.isdigit() and int(step) in steps:
                    fout.write(line.rstrip() + "\n")


def process(c, R, w, post: Path):
    from pyCascade import probePost

    run_oak = CHARLES / f"config{c}/R{R}"
    pq = run_oak / "probes/probesOut_parquet"
    loc = run_oak / "probes/locations"
    pq.mkdir(parents=True, exist_ok=True)
    loc.mkdir(parents=True, exist_ok=True)

    print(f"config{c} R{R}: point clouds from {post}")
    probePost.Probes(str(post), directory_parquet=str(pq), probe_type="POINTCLOUD_PROBES",
                     file_type="csv").to_parquet(overwrite=True)

    steps = set(range(w["reset"], w["post"] + 1, 1000))
    assert w["post"] in steps
    with tempfile.TemporaryDirectory(dir=SCRATCH / f"config{c}/R{R}/post/{w['post']:08d}") as stage:
        print(f"config{c} R{R}: extra probes, {len(steps)} steps {min(steps)}-{max(steps)}")
        stage_extra_probes(SCRATCH / f"config{c}/R{R}/probes/probesOut", Path(stage), steps)
        probePost.Probes(stage, directory_parquet=str(pq), probe_type="PROBES", file_type="csv",
                         name_pattern="extraProbe").to_parquet(overwrite=True)

    shutil.copy2(CHARLES / f"config{c}/noInt_locations/nameKey_extraProbe.txt", loc / "nameKey_extraProbe.txt")

    log = run_oak / f"getVentilationStats-{w['post']}.out"
    print(f"config{c} R{R}: getVentilationStats.py -> probes/flowStats-{w['reset']}to{w['post']}.csv (log {log.name})")
    with open(log, "w") as f:
        subprocess.run([sys.executable, "getVentilationStats.py", f"config{c}", str(R), "POINTCLOUD_PROBES",
                        f"{w['reset']},", f"{w['post']},"], cwd=CB, stdout=f, stderr=subprocess.STDOUT, check=True)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("config", nargs="?", type=int, choices=[2, 3])
    ap.add_argument("--runs", nargs="+", type=int, help="only these R numbers")
    ap.add_argument("--overwrite", action="store_true", help="reprocess runs that already have their csv")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()
    if os.environ.get("OAK_HOME") != str(CB.parents[1]):
        sys.exit(f"getVentilationStats.py writes under $OAK_HOME/Cascade/city_block_cfd; set OAK_HOME={CB.parents[1]}")
    queued = queued_jobs()
    todo = []
    for c, R, src, w in twins():
        if (args.config and c != args.config) or (args.runs and R not in args.runs):
            continue
        st, post, csv = status(c, R, w, args.overwrite, queued)
        print(f"config{c} R{R} (twin of R{src}, {w['reset']}-{w['post']}): {st}")
        if st == "process":
            todo.append((c, R, w, post))
    if args.dry_run or not todo:
        return
    for c, R, w, post in todo:
        process(c, R, w, post)
    print(f"processed {len(todo)} run(s)")


if __name__ == "__main__":
    main()
