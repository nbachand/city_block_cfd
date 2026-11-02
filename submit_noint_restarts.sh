#!/bin/bash
# Queue one continuation job per matched pressure-only run (R76-R99), to start when its current job
# ends (--dependency=afterany). The job (CHARLES/charles-restart-noInt.slurm) exits at once if the run
# finished, stops if the run failed, and otherwise restarts it from its newest complete snapshot.
#
#   bash submit_noint_restarts.sh 3 --dry-run   # list what would be queued
#   bash submit_noint_restarts.sh 3             # queue continuations for config3 (or 2)
#
# A run is skipped if it has no job queued or running under its name (cc<C>_R<R>), or if its
# continuation (cc<C>_R<R>r) is already queued. Job IDs are appended to
# CHARLES/config<C>/matched_noint_jobs.txt.

set -u
C=""
DRY=""
for arg in "$@"; do
    case $arg in
        2|3) C=$arg ;;
        --dry-run) DRY=1 ;;
        *) echo "usage: submit_noint_restarts.sh 2|3 [--dry-run]"; exit 1 ;;
    esac
done
[ -n "$C" ] || { echo "usage: submit_noint_restarts.sh 2|3 [--dry-run]"; exit 1; }
CHARLES=/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/CHARLES
LOG=$CHARLES/config$C/matched_noint_jobs.txt
jobs=$(squeue --me -h -o "%j %i")

for R in $(seq 76 99); do
    name=cc${C}_R$R
    id=$(awk -v n="$name" '$1 == n {print $2}' <<< "$jobs" | head -1)
    if [ -z "$id" ]; then echo "config$C R$R: no $name job queued or running, skipped"; continue; fi
    if awk -v n="${name}r" '$1 == n {f=1} END {exit !f}' <<< "$jobs"; then
        echo "config$C R$R: ${name}r already queued, skipped"; continue
    fi
    if [ -n "$DRY" ]; then echo "config$C R$R: would queue ${name}r after job $id"; continue; fi
    out=$(cd "$CHARLES/config$C/R$R" && sbatch --dependency=afterany:"$id" --job-name="${name}r" \
          ../../charles-restart-noInt.slurm) || { echo "config$C R$R: sbatch failed: $out"; continue; }
    echo "config$C R$R: $out (after $id)"
    echo "$(date '+%F %T') config$C R$R continuation $out after $id" >> "$LOG"
done
