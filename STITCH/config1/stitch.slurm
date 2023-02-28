#!/bin/bash
#SBATCH --job-name=stitch
#SBATCH -c 1
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p bigmem
#SBATCH --time=2:00:00
#SBATCH --mem=512G

module purge

module load system
module load libpng/1.2.57
module load openmpi/2.1.1

source ~/.bash_profile

PARENT_DIR="Cascade/city_block_cfd/STITCH"
LOCAL_FOLDER=$(basename "`pwd`")

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Executing stitch from $(pwd)"

mpiexec stitch.exe -i $HOME/$PARENT_DIR/$LOCAL_FOLDER/stitch.in
# mpiexec stitch.exe -i $HOME/$PARENT_DIR/$LOCAL_FOLDER/stitch-fine.in
