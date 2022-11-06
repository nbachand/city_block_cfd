#!/bin/bash
#SBATCH --job-name=charles_single_family
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=0:10:00
#SBATCH --mem 64G

export CTI_LICENSE=$HOME/Cascade/license.dat

module purge

module load system
module load libpng/1.2.57
module load openmpi/2.1.1

PARENT_DIR="Cascade/city_block_cfd/CHARLES/single_family"
LOCAL_FOLDER=$(basename "`pwd`")

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Executing charles from $(pwd)"

mpiexec $HOME/$PARENT_DIR/0_deg/charles.exe -i $HOME/$PARENT_DIR/0_deg/charles.in
# $HOME/$PARENT_DIR/charles.exe -i $HOME/$PARENT_DIR/charles.in
