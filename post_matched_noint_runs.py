#!/usr/bin/env python3
"""Write the shared POST files for the pressure-only (no-interior) runs of each config.

    python3 -I post_matched_noint_runs.py            # dry run
    python3 -I post_matched_noint_runs.py --write    # (re)write CHARLES/config{2,3}/charles-post-noInt.{in,slurm}

Use (from a pressure-only run's Oak folder, e.g. CHARLES/config2/R82):

    sbatch ../charles-post-noInt.slurm 119000      # POST of data/result.00119000.sles

The slurm script makes $SCRATCH/.../R<R>/post/<step>/, copies the shared input there with SNAPSHOT
replaced by the 8-digit step, and runs the run's own charles.exe in POST mode. Outputs (opening point
clouds in probes/probesOut/, images in Images/) stay in that folder, separate from a running job's.

The input follows CHARLES/config<C>/charles-post.in (POST, STATS u mag(u) p, OVERWRITE_STATS=false so
the snapshot's running averages are read, not reset), with: RESTART on the pressure-only mesh from the
snapshot (no interpolation); the pressure-only mesh's boundary conditions; the template's 336 opening
POINTCLOUD_PROBEs (VARS p_avg p_rms comp(u_avg,0..2)) switched on, located by
CHARLES/config<C>/noInt_locations/ (identical to the point clouds R57-60 / R25-28 recorded in 2024);
and the pressure-only runs' averaged images (INTERVAL=$(image_int_avg) lines, written once). Boundary
conditions and image lines are taken from the config's no-interior template run and are identical in
every matched run of the config.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

CB = Path("/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd")
CHARLES = CB / "CHARLES"
MESH = {2: CB / "STITCH/config2/7M-mesh-noInteriors.mles", 3: CB / "STITCH/config3/13M-mesh-noInteriors.mles"}
TEMPLATE_RUN = {2: 59, 3: 27}

SLURM = r"""#!/bin/bash
# POST of one snapshot of a pressure-only run (written by city_block_cfd/post_matched_noint_runs.py).
# Submit from the run's Oak folder:  sbatch ../charles-post-noInt.slurm <step>
#SBATCH --job-name=post_noInt
#SBATCH --output=post-%j.out
#SBATCH -n 16
#SBATCH --mem-per-cpu=7G
#SBATCH --time=01:00:00
#SBATCH --partition=serc
#SBATCH --constraint=[CLASS:SH4_CBASE|CLASS:SH4_CPERF|CLASS:SH3_CBASE.1]
export CTI_LICENSE=$HOME/Cascade/license.dat

set -eu
module purge
module load system
module load libpng/1.2.57
module load openmpi/2.1.1

STEP=$(printf %08d "${1:?usage: sbatch ../charles-post-noInt.slurm <step>}")
CONFIG_DIR={config_dir}
RUN=$(basename "$(pwd)")
SCR=$SCRATCH/Cascade/city_block_cfd/CHARLES/{config}/$RUN
POST=$SCR/post/$STEP
[ -f "$SCR/data/result.$STEP.sles" ] || { echo "no snapshot $SCR/data/result.$STEP.sles"; exit 1; }
if [ -n "$(ls -A "$POST/probes/probesOut" 2>/dev/null)" ]; then echo "$POST already has outputs"; exit 1; fi
mkdir -p "$POST/probes/probesOut" "$POST/Images"
sed "s/SNAPSHOT/$STEP/" "$CONFIG_DIR/charles-post-noInt.in" > "$POST/charles-post.in"
EXE=$CONFIG_DIR/$(grep -oE "charles/[0-9a-z_]+/charles\.exe" charles.slurm | head -1)
cd "$POST"
echo "POST of $RUN result.$STEP.sles in $(pwd) with $EXE"
source ~/.bash_profile
srun "$EXE" -i "$POST/charles-post.in"
"""


def build_input(c: int) -> str:
    run_in = (CHARLES / f"config{c}/R{TEMPLATE_RUN[c]}/charles.in").read_text()
    template = (CHARLES / f"config{c}/charles-post.in").read_text()
    bcs = re.findall(r"^\s*\w+\s*=\s*(?:WM_ALG_WALL|SLIP).*$", run_in, flags=re.M)
    images = [l for l in run_in.splitlines()
              if re.match(r"\s*WRITE_IMAGE\b", l) and "INTERVAL=$(image_int_avg)" in l]
    clouds = [re.sub(r"^#+\s*#\s*", "", l) for l in template.splitlines() if "POINTCLOUD_PROBE" in l]
    assert bcs and images, "template run sections not found"
    assert len(clouds) == 336 and all(l.startswith("POINTCLOUD_PROBE") for l in clouds), "template point clouds"
    names = [re.search(r"location_path\)/(\S+)", l).group(1) for l in clouds]
    missing = [n for n in names if not (CHARLES / f"config{c}/noInt_locations/{n}").exists()]
    assert not missing, f"missing location files: {missing[:3]}"
    return "\n".join([
        f"# Shared POST input for config{c} pressure-only runs. Do not run directly: charles-post-noInt.slurm",
        "# copies it to <run scratch>/post/<step>/ and replaces SNAPSHOT with the 8-digit step.",
        "POST",
        f"RESTART = {MESH[c]} ../../data/result.SNAPSHOT.sles",
        "",
        "#Equation of state",
        "EOS HELMHOLTZ", "RHO = 1.225", "MU = 1.7894e-5", "HELMHOLTZ_SOS 340.65",
        "",
        "#Boundary Conditions (pressure-only mesh zones)",
        *bcs,
        "",
        "STATS u mag(u) p",
        "OVERWRITE_STATS=false #default true",
        "",
        "DEFINE flush_probes=1000",
        "DEFINE probe_path=probes/probesOut",
        f"DEFINE location_path={CHARLES / f'config{c}/noInt_locations'}",
        "FLUSH_PROBES $(flush_probes)",
        "DEFINE probe_int=1",
        "DEFINE image_int_avg=1",
        "DEFINE image_int=1",
        "",
        f"# Opening surface point clouds (config{c}/charles-post.in, switched on)",
        *clouds,
        "",
        "# Averaged images of the pressure-only runs",
        *images,
        "",
    ])


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--write", action="store_true")
    args = ap.parse_args()
    for c in (2, 3):
        text = build_input(c)
        d = CHARLES / f"config{c}"
        print(f"config{c}: {text.count('POINTCLOUD_PROBE')} point clouds, {text.count('WRITE_IMAGE')} images "
              f"-> {d}/charles-post-noInt.in, charles-post-noInt.slurm")
        if args.write:
            (d / "charles-post-noInt.in").write_text(text)
            slurm = d / "charles-post-noInt.slurm"
            slurm.write_text(SLURM.replace("{config_dir}", str(d)).replace("{config}", f"config{c}"))
            slurm.chmod(0o770)


if __name__ == "__main__":
    main()
