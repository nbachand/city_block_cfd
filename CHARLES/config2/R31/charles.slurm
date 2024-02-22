#!/bin/bash
#SBATCH --job-name=cc2_R31
#SBATCH -N 8
#SBATCH -n 256
#SBATCH --time=24:00:00
#SBATCH --mem 128G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL
#SBATCH --constraint="[CLASS:SH3_CBASE|CLASS:SH3_CBASE.1|CPU_GEN:SKX]" 
export CTI_LICENSE=$HOME/Cascade/license.dat

module purge
module load system
module load libpng/1.2.57
module load openmpi/4.1.2


PARENT_DIR="Cascade/city_block_cfd/CHARLES/config2"
LOCAL_FOLDER=$(basename "`pwd`")

cp ./*.dat $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER/

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Executing charles from $(pwd)"

source ~/.bash_profile
srun /home/groups/gorle/codes/cascade-master-openmpi4/src/charles/charles_helm.exe -i $OAK_HOME/$PARENT_DIR/$LOCAL_FOLDER/charles.in
