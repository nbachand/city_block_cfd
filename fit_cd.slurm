#!/bin/bash
# In-network C_d fits of config2_post-multiRun_flowModel.ipynb (cells 32, 34, 41, 43), one array task
# per fit (cdFits.py, fit_cd.py), on any recent CPU-only node class of serc or owners. Export the inputs from the notebook first (cell before cell 32), then:
#
#   sbatch fit_cd.slurm                       # all four fits
#   sbatch --array=2 fit_cd.slurm             # only pPoint
#   sbatch --export=ALL,RESUME=1 fit_cd.slurm # restart from each fit's evaluation log (after a time-out)
#
# Results: CHARLES/multiRuns/cdFits/<fit>.json (load_fit in the notebook), progress in <fit>-evals.csv.
# Speed: ~2-3 s per objective evaluation on 24 cores (144 s serial in the notebook); past fits took
# 100-350 evaluations, so 2 h leaves a wide margin (RESUME=1 continues a fit that times out).
#SBATCH --job-name=cdfit
#SBATCH --partition=serc,owners
#SBATCH --constraint=CLASS:SH4_CPERF|CLASS:SH4_CBASE|CLASS:SH4_CSCALE|CLASS:SH3_CPERF|CLASS:SH3_CBASE|CLASS:SH3_CBASE.1
#SBATCH --requeue
#SBATCH --array=0-3
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --output=CHARLES/multiRuns/cdFits/slurm-%x-%A_%a.out
#SBATCH --mail-type=END,FAIL

FITS=(pBulk qBulk pPoint qPoint)
FIT=${FITS[$SLURM_ARRAY_TASK_ID]}

module load system
source ~/.bash_profile
conda activate pycascade
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1  # one process per core
export TQDM_DISABLE=1

cd /oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd
echo "fit $FIT on $(hostname), $SLURM_CPUS_PER_TASK CPUs, job $SLURM_ARRAY_JOB_ID task $SLURM_ARRAY_TASK_ID"
# owners jobs can be preempted and requeued: a requeued task continues from its evaluation log
[ "${SLURM_RESTART_COUNT:-0}" -gt 0 ] && RESUME=1
python fit_cd.py "$FIT" --workers "$SLURM_CPUS_PER_TASK" ${RESUME:+--resume}
