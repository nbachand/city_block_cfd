#!/bin/bash
#SBATCH --job-name=charles_single_family
#SBATCH -c 1
#SBATCH -N 1
#SBATCH -n 32
#SBATCH --time=24:00:00

module purge

module load system
module load libpng/1.2.57
module load openmpi/2.1.1

PARENT_DIR="Cascade/city_block_cfd/CHARLES/single_family"
LOCAL_FOLDER=$(basename "`pwd`")

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Executing charles from $(pwd)"

mpiexec $HOME/$PARENT_DIR/charles.exe -i $HOME/$PARENT_DIR/charles.in
# $HOME/$PARENT_DIR/charles.exe -i $HOME/$PARENT_DIR/charles.in
