#!/bin/bash
#SBATCH --job-name=c1_R1
#SBATCH -n 128
#SBATCH --time=18:00:00
#SBATCH -N 4

export CTI_LICENSE=$HOME/Cascade/license.dat

module purge

module load system
module load libpng/1.2.57
module load openmpi/4.1.0
# module load openmpi/2.1.1

PARENT_DIR="Cascade/city_block_cfd/CHARLES/config1"
LOCAL_FOLDER=$(basename "`pwd`")

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Executing charles from $(pwd)"

source ~/.bash_profile
# mpiexec charles.exe -i $HOME/$PARENT_DIR/$LOCAL_FOLDER/charles.in
mpiexec $HOME/$PARENT_DIR/../single_family/0_deg/charles.exe -i $HOME/$PARENT_DIR/$LOCAL_FOLDER/charles.in
# $HOME/$PARENT_DIR/charles.exe -i $HOME/$PARENT_DIR/charles.in
