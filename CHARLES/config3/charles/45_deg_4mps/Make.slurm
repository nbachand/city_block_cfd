#!/bin/bash
#SBATCH --job-name=charlesMake
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=01:05:00
#SBATCH --mem=8G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL

source ~/.bash_profile

module purge

module load system
module load libpng/1.2.57
module load openmpi/2.1.1

module list

make clean
make
