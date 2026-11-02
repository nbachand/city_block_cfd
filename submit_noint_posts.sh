#!/bin/bash
# Submit the window-end POST pass (CHARLES/config<C>/charles-post-noInt.slurm) for every matched
# pressure-only run (R76-R99) that has finished.
#
#   bash submit_noint_posts.sh --dry-run     # list what would be submitted (also: 2 --dry-run)
#   bash submit_noint_posts.sh [2|3]         # submit (default: both configs)
#
# POST step: ΔT 0 twins (R76-R87) 119000, since general_mods.hpp resets stats at step 120000;
# ΔT 5 twins (R88-R99) 240000. A run counts as finished when its newest slurm log reached NSTEPS
# and no job of it (cc<C>_R<R> or its continuation cc<C>_R<R>r) is queued or running. A run is skipped
# if its POST folder already has outputs or a POST job for it (post<C>_R<R>) is queued or running.
# R78 and R90 (twins of the R48 rerun) are included like the others; their pressures only become
# matched once R48 itself is reprocessed. Job IDs are appended to CHARLES/config<C>/matched_noint_jobs.txt.

set -u
CONFIGS="2 3"
DRY=""
for arg in "$@"; do
    case $arg in
        2|3) CONFIGS=$arg ;;
        --dry-run) DRY=1 ;;
        *) echo "usage: submit_noint_posts.sh [2|3] [--dry-run]"; exit 1 ;;
    esac
done
CHARLES=/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/CHARLES
queued=$(squeue --me -h -o "%j")

for C in $CONFIGS; do
    for R in $(seq 76 99); do
        d=$CHARLES/config$C/R$R
        scr=$SCRATCH/Cascade/city_block_cfd/CHARLES/config$C/R$R
        if [ "$R" -le 87 ]; then STEP=119000; else STEP=240000; fi
        S8=$(printf %08d $STEP)
        tag="config$C R$R (step $STEP)"
        [ -f "$d/charles.in" ] || { echo "$tag: not set up, skipped"; continue; }
        if grep -qxE "cc${C}_R${R}r?" <<< "$queued"; then echo "$tag: still running, skipped"; continue; fi
        log=$(ls -t "$d"/slurm-*.out 2>/dev/null | head -1)
        nsteps=$(grep -oE "^NSTEPS = [0-9]+" "$d/charles.in" | awk '{print $3}')
        last=$([ -n "$log" ] && grep -E "^ starting step:" "$log" | tail -1 | awk '{print $3}')
        if [ -z "$last" ] || [ "$last" -lt "$nsteps" ]; then echo "$tag: not finished (step ${last:-none}), skipped"; continue; fi
        [ -f "$scr/data/result.$S8.sles" ] || { echo "$tag: MISSING snapshot result.$S8.sles, skipped"; continue; }
        if [ -n "$(ls -A "$scr/post/$S8/probes/probesOut" 2>/dev/null)" ]; then echo "$tag: POST already done"; continue; fi
        if grep -qx "post${C}_R$R" <<< "$queued"; then echo "$tag: POST already queued"; continue; fi
        if [ -n "$DRY" ]; then echo "$tag: would submit post${C}_R$R"; continue; fi
        out=$(cd "$d" && sbatch --job-name="post${C}_R$R" ../charles-post-noInt.slurm $STEP) \
            || { echo "$tag: sbatch failed: $out"; continue; }
        echo "$tag: $out"
        echo "$(date '+%F %T') config$C R$R POST $STEP $out" >> "$CHARLES/config$C/matched_noint_jobs.txt"
    done
done
