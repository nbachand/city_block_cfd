#!/bin/bash
#SBATCH --job-name=surfer
#SBATCH -c 1
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -p dev
#SBATCH --time=5:00

module purge

module load system
module load libpng/1.2.57

surfer.exe -i ./geom_prep.in
