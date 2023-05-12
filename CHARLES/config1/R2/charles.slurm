#!/bin/bash
#SBATCH --job-name=cc1_R2
#SBATCH -N 8
#SBATCH -n 256
#SBATCH --mem=200G
#SBATCH --time=20:00:00
#SBATCH --partition=serc
#SBATCH --constraint="[CLASS:SH3_CBASE|CLASS:SH3_CBASE.1|CPU_GEN:SKX]" 
#SBATCH --mail-type=ALL
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
srun $HOME/$PARENT_DIR/charles/charles.exe -i $HOME/$PARENT_DIR/$LOCAL_FOLDER/charles.in
# srun $HOME/$PARENT_DIR/../single_family/0_deg_spinnup2/charles.exe -i $HOME/$PARENT_DIR/$LOCAL_FOLDER/charles.in
