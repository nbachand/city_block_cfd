"""Build the two Stanford Digital Repository upload folders from the current processed results.

    python sdr/build_upload.py [--out tmp/sdr_upload] [--force]

Both deposits hold raw LES statistics only (no model results), as flat files:

1_window_room_data/        (original deposit)
    flowStatsMI.csv, roomVentilationMI.csv           rows of the runs with slAll == False
    README.md                                         sdr/README_window_room.md

2_skylight_pressure_data/  (companion deposit)
    flowStatsMI_slAll.csv, roomVentilationMI_slAll.csv   rows of the runs with slAll == True
    pointCloudStatsNoIntMatchedMI.csv                     matched pressure-only twins' opening stats
    README.md                                         sdr/README_skylight_pressure.md + the Terminology
                                                      section of sdr/README_window_room.md

The slAll split is done line by line on the CSV text, so every row is byte-identical to the source, and
it is checked by reloading both halves and comparing them with the source. The pressure-only table is
written by config2_post-multiRun_flowModel.ipynb (cell 12); the script checks it is not older than
flowStatsMI.csv. Edit the deposit READMEs in sdr/, not the copies in the output folder: the column
definitions (Terminology) live only in sdr/README_window_room.md and are appended to the second README.
"""
import argparse
import shutil
import sys
from pathlib import Path

import pandas as pd

HOME = Path(__file__).resolve().parent.parent
MULTI = Path("CHARLES/multiRuns")
SPLIT = ["flowStatsMI", "roomVentilationMI"]  # split by slAll
PRESSURE_ONLY = MULTI / "pointCloudStatsNoIntMatchedMI.csv"
WINDOW_ROOM = "1_window_room_data"
SKYLIGHT_PRESSURE = "2_skylight_pressure_data"

# (source relative to HOME, destination relative to the output folder)
README_WINDOW_ROOM = Path("sdr/README_window_room.md")
README_SKYLIGHT_PRESSURE = Path("sdr/README_skylight_pressure.md")
COPIES = [
    (README_WINDOW_ROOM, Path(WINDOW_ROOM) / "README.md"),
    (PRESSURE_ONLY, Path(SKYLIGHT_PRESSURE) / PRESSURE_ONLY.name),
]


def write_skylight_pressure_readme(dst):
    """The second README: its own sections plus the Terminology section of the window/room README, so
    each deposit defines all of its columns. The one link in Terminology that points outside it
    ([roomVentilationMI](#datasets)) is pointed at the second README's Row IDs section."""
    full = (HOME / README_WINDOW_ROOM).read_text()
    start, end = "\n## Terminology\n", "\n## Version History\n"
    if full.count(start) != 1 or full.count(end) != 1:
        sys.exit(f"{README_WINDOW_ROOM}: expected one '## Terminology' and one '## Version History' heading")
    terminology = start.lstrip("\n") + full.split(start)[1].split(end)[0].strip("\n") + "\n"
    terminology = terminology.replace("](#datasets)", "](#row-ids)")
    own = (HOME / README_SKYLIGHT_PRESSURE).read_text().rstrip("\n")
    if "## Terminology" in own:
        sys.exit(f"{README_SKYLIGHT_PRESSURE} already has a Terminology section; it is appended by this script")
    text = own + "\n\n" + terminology
    if "TODO" in text:
        sys.exit(f"{README_SKYLIGHT_PRESSURE} still has a TODO placeholder: fill it in before building")
    dst.write_text(text)


def split_by_slall(src, dst_false, dst_true):
    """Write src's rows with slAll False / True to the two files; return the row and run counts."""
    df = pd.read_csv(src, index_col=[0, 1])
    per_run = df.groupby(level=0)["slAll"].agg(set)
    mixed = per_run[per_run.map(len) != 1]
    if len(mixed):
        sys.exit(f"{src}: runs with mixed slAll: {list(mixed.index)}")
    is_true = {str(run): bool(next(iter(v))) for run, v in per_run.items()}

    counts = {False: 0, True: 0}
    with open(src) as fh, open(dst_false, "w") as out_f, open(dst_true, "w") as out_t:
        header = fh.readline()
        out_f.write(header)
        out_t.write(header)
        for line in fh:
            run = line.split(",", 1)[0]
            if run not in is_true:
                sys.exit(f"{src}: run id {run!r} on a row is not in the parsed index")
            (out_t if is_true[run] else out_f).write(line)
            counts[is_true[run]] += 1

    halves = [pd.read_csv(p, index_col=[0, 1]) for p in (dst_false, dst_true)]
    if not ((halves[0]["slAll"] == False).all() and (halves[1]["slAll"] == True).all()):
        sys.exit(f"{src}: split check failed (slAll)")
    if not pd.concat(halves).sort_index().equals(df.sort_index()):
        sys.exit(f"{src}: split check failed (halves do not recombine to the source)")
    runs = {k: sum(v == k for v in is_true.values()) for k in (False, True)}
    return counts, runs


def check_consistency():
    """Warn when the pressure-only table looks older than the window statistics it is keyed to."""
    mtime = lambda p: (HOME / p).stat().st_mtime
    warnings = []
    if mtime(PRESSURE_ONLY) < mtime(MULTI / "flowStatsMI.csv"):
        warnings.append(f"{PRESSURE_ONLY.name} is older than flowStatsMI.csv: "
                        "re-run cell 12 of config2_post-multiRun_flowModel.ipynb if the run set changed")
    for w in warnings:
        print(f"WARNING: {w}")
    return warnings


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--out", default="tmp/sdr_upload", help="output folder, relative to the repository root")
    ap.add_argument("--force", action="store_true", help="replace existing upload folders in --out")
    args = ap.parse_args()

    out = HOME / args.out
    targets = [out / WINDOW_ROOM, out / SKYLIGHT_PRESSURE]
    existing = [t for t in targets if t.exists()]
    if existing and not args.force:
        sys.exit(f"{', '.join(map(str, existing))} already exist; pass --force to replace them")
    missing = [str(src) for src, _ in COPIES + [(README_SKYLIGHT_PRESSURE, None)] if not (HOME / src).exists()]
    missing += [str(MULTI / f"{f}.csv") for f in SPLIT if not (HOME / MULTI / f"{f}.csv").exists()]
    if missing:
        sys.exit("missing source files:\n  " + "\n  ".join(missing))

    for readme in (README_WINDOW_ROOM, README_SKYLIGHT_PRESSURE):
        if "TODO" in (HOME / readme).read_text():
            sys.exit(f"{readme} still has a TODO placeholder: fill it in before building")
    warnings = check_consistency()
    for t in existing:
        shutil.rmtree(t)
    for t in targets:
        t.mkdir(parents=True)

    for f in SPLIT:
        counts, runs = split_by_slall(HOME / MULTI / f"{f}.csv",
                                      out / WINDOW_ROOM / f"{f}.csv",
                                      out / SKYLIGHT_PRESSURE / f"{f}_slAll.csv")
        print(f"{f}: slAll False {runs[False]} run ids / {counts[False]} rows -> {WINDOW_ROOM}; "
              f"slAll True {runs[True]} run ids / {counts[True]} rows -> {SKYLIGHT_PRESSURE}")
    for src, dst in COPIES:
        shutil.copy2(HOME / src, out / dst)
    write_skylight_pressure_readme(out / SKYLIGHT_PRESSURE / "README.md")

    print(f"\n{out}:")
    for p in sorted(q for q in out.rglob("*") if q.is_file() and any(t in q.parents for t in targets)):
        print(f"  {p.stat().st_size / 1e6:9.3f} MB  {p.relative_to(out)}")
    if warnings:
        print(f"\n{len(warnings)} warning(s) above: check them before uploading")


if __name__ == "__main__":
    main()
