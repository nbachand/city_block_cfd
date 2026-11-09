#!/bin/bash
# Continue a matched pressure-only run (CHARLES/config<C>/R76-R99) that hit the wall-clock limit.
# Submitted by city_block_cfd/submit_noint_restarts.sh from the run's Oak folder, with
# --dependency=afterany:<running job> and --job-name=cc<C>_R<R>r.
#
#   DRYRUN=1 bash ../../charles-restart-noInt.slurm    # from a run's Oak folder: show what it would do
#
# On start it checks that the previous job (newest other slurm-*.out) ended in TIMEOUT; if it
# completed it exits, if it failed it stops for a look. It then restarts from the newest snapshot
# the previous job is known to have finished writing (its log reached >= 100 steps past it):
#  - charles-restart-<step>.in (Oak run folder) is charles.in with RESTART pointing at that snapshot,
#    INTERP_FROM_RESTART commented out, and RESET_STATS commented out so the running averages in the
#    snapshot carry on (a TIME threshold already passed might fire again on restart).
#  - The controller's integral is not in the snapshot (general_mods.hpp keeps it in memory and starts
#    it at 0). Instead of "0 0 0", whose u = 0 first read sets the integral to dt*100*u_ref and
#    overshoots the flow aloft by ~35% for ~2000 steps, VolProbe90X/Z.svp are seeded with the last
#    velocities the previous job measured, so the integral rebuilds from a ~0.1% velocity deficit.
#SBATCH -n 48
#SBATCH --mem-per-cpu=7G
#SBATCH --time=4-00:00:00
#SBATCH --partition=serc
#SBATCH --mail-type=ALL
#SBATCH --constraint=[CLASS:SH4_CBASE|CLASS:SH4_CPERF|CLASS:SH3_CBASE.1]
export CTI_LICENSE=$HOME/Cascade/license.dat

set -eu
DRYRUN=${DRYRUN:-}
OAKRUN=$(pwd)
RUN=$(basename "$OAKRUN")
CONFIG=$(basename "$(dirname "$OAKRUN")")
SCR=$SCRATCH/Cascade/city_block_cfd/CHARLES/$CONFIG/$RUN
SELF=slurm-${SLURM_JOB_ID:-none}.out
die() { echo "$RUN: $*"; exit 1; }

PREV=$(ls -t slurm-*.out 2>/dev/null | grep -vx "$SELF" | head -1) || true
[ -n "$PREV" ] || die "no previous slurm log"
PREV_ID=${PREV#slurm-}; PREV_ID=${PREV_ID%.out}
STATE=$(sacct -j "$PREV_ID" -X -n -o State | head -1 | awk '{print $1}')
NSTEPS=$(grep -oE "^NSTEPS = [0-9]+" charles.in | awk '{print $3}')
LAST=$(grep -E "^ starting step:" "$PREV" | tail -1 | awk '{print $3}')
echo "$RUN: previous job $PREV_ID $STATE at step $LAST of $NSTEPS"
if [ "$STATE" = COMPLETED ] || [ "$LAST" -ge "$NSTEPS" ]; then echo "$RUN: finished, nothing to do"; exit 0; fi
[ "$STATE" = TIMEOUT ] || [ -n "$DRYRUN" ] || die "previous job ended $STATE, not TIMEOUT: check it before restarting"

K=$(( (LAST - 100) / 1000 * 1000 ))
while [ "$K" -gt 0 ] && [ ! -f "$SCR/data/result.$(printf %08d $K).sles" ]; do K=$((K - 1000)); done
[ "$K" -gt 0 ] || die "no complete snapshot found"
SNAP=$SCR/data/result.$(printf %08d $K).sles
UT=$(grep -E "^>>>>> u_t is" "$PREV" | tail -1 | awk '{print $4}')
WT=$(grep -E "^>>>>> w_t is" "$PREV" | tail -1 | awk '{print $4}')
[ -n "$UT" ] && [ -n "$WT" ] || die "no controller velocities in $PREV"

IN=$OAKRUN/charles-restart-$(printf %08d $K).in
[ -n "$DRYRUN" ] && IN=$(mktemp)
sed -E -e "1s|^(RESTART = [^ #]+\.mles).*|\1 $SNAP|" \
       -e "s|^INTERP_FROM_RESTART|# (restart) INTERP_FROM_RESTART|" \
       -e "s|^RESET_STATS|# (restart: keep the snapshot's running averages) RESET_STATS|" charles.in > "$IN"
grep -qx "RESTART = .*\.mles $SNAP" "$IN" || die "RESTART line not set in $IN"
! grep -qE "^(INTERP_FROM_RESTART|RESET_STATS|RESET_ALL|INIT)\b" "$IN" || die "start-up command left active in $IN"
EXE=$(dirname "$OAKRUN")/$(grep -oE "charles/[0-9a-z_]+/charles\.exe" charles.slurm | head -1)
[ -x "$EXE" ] || die "no executable $EXE"

echo "$RUN: restart from $SNAP ($((LAST - K)) steps after it are recomputed)"
echo "$RUN: controller seeded with u_t $UT, w_t $WT; input $IN"
if [ -n "$DRYRUN" ]; then diff charles.in "$IN" || true; rm -f "$IN"; exit 0; fi

module purge
module load system
module load libpng/1.2.57
module load openmpi/2.1.1
cd "$SCR"
echo "0 0 $UT" > ./probes/VolProbe90X.svp
echo "0 0 $WT" > ./probes/VolProbe90Z.svp
echo "Executing charles from $(pwd)"
set +u  # /etc/bashrc (via ~/.bash_profile) reads PS1, unset in batch jobs
source ~/.bash_profile
set -u
srun "$EXE" -i "$IN"
