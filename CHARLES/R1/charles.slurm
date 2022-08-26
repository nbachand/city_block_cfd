#!/bin/bash
#SBATCH --job-name=charles_city_block
#SBATCH -c 1
#SBATCH -N 1
#SBATCH -n 3
#SBATCH --time=1:00:00

module purge

module load system
module load libpng/1.2.57
module load openmpi/2.1.1

PARENT_DIR="$SCRATCH/Cascade/city_block_cfd/CHARLES/"
LOCAL_FOLDER=$(basename "`pwd`")

cd $PARENT_DIR$LOCAL_FOLDER

echo "Executing charles from $(pwd)"

mpiexec $HOME/Cascade/city_block_cfd/CHARLES/charles.exe -i $HOME/Cascade/city_block_cfd/CHARLES/charles.in
