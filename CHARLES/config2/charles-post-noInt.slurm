#!/bin/bash
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
CONFIG_DIR=/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/CHARLES/config2
RUN=$(basename "$(pwd)")
SCR=$SCRATCH/Cascade/city_block_cfd/CHARLES/config2/$RUN
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
