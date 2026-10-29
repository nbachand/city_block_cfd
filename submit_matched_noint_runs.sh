#!/bin/bash
# Submit the matched pressure-only runs (R76-R99) created by setup_matched_noint_runs.py.
#
#   bash submit_matched_noint_runs.sh              # submit config2 and config3
#   bash submit_matched_noint_runs.sh 2            # submit config2 only (or 3)
#   bash submit_matched_noint_runs.sh --dry-run    # only list what would be submitted (also: 2 --dry-run)
#
# Each job is submitted from its Oak run folder (charles.slurm derives the scratch folder from it).
# A run is skipped if its folder or scratch folder is missing (e.g. config2 R78/R90, waiting for the
# R48 rerun), if it already has a slurm log, or if a job with its name is already queued or running.
# Submitted job IDs are appended to CHARLES/config<C>/matched_noint_jobs.txt.

set -u
CONFIGS="2 3"
DRY=""
for arg in "$@"; do
    case $arg in
        2|3) CONFIGS=$arg ;;
        --dry-run) DRY=1 ;;
        *) echo "usage: submit_matched_noint_runs.sh [2|3] [--dry-run]"; exit 1 ;;
    esac
done
queued=$(squeue --me -h -o "%j")

for C in $CONFIGS; do
    OAK_RUNS=/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/CHARLES/config$C
    SCRATCH_RUNS=$SCRATCH/Cascade/city_block_cfd/CHARLES/config$C
    LOG=$OAK_RUNS/matched_noint_jobs.txt
    for R in $(seq 76 99); do
        d=$OAK_RUNS/R$R
        name=cc${C}_R$R
        if [ ! -f "$d/charles.slurm" ] || [ ! -d "$SCRATCH_RUNS/R$R/probes/locations" ]; then
            echo "config$C R$R: not set up, skipped"; continue
        fi
        if ls "$d"/slurm-*.out >/dev/null 2>&1; then
            echo "config$C R$R: already has a slurm log, skipped"; continue
        fi
        if grep -qx "$name" <<< "$queued"; then
            echo "config$C R$R: $name already queued/running, skipped"; continue
        fi
        if [ -n "$DRY" ]; then
            echo "config$C R$R: would submit ($name)"; continue
        fi
        out=$(cd "$d" && sbatch charles.slurm) || { echo "config$C R$R: sbatch failed: $out"; continue; }
        echo "config$C R$R: $out"
        echo "$(date '+%F %T') config$C R$R $out" >> "$LOG"
    done
done
