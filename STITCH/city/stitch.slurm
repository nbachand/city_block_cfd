#!/bin/bash
#SBATCH --job-name=stitch
#SBATCH -c 1
#SBATCH -N 1
#SBATCH -n 32
# SBATCH -p bigmem
#SBATCH --time=5:00:00
# SBATCH --mem=512G

module purge

module load system
module load libpng/1.2.57
module load openmpi/2.1.1

mpiexec stitch.exe -i stitch_paper_halfed.in