#!/bin/bash
#SBATCH --job-name=cc2_R62
#SBATCH -N 4
#SBATCH -n 128
#SBATCH --time=120:00:00
#SBATCH --mem 128G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL
export CTI_LICENSE=$HOME/Cascade/license.dat

module purge

module load system
module load libpng/1.2.57
# module load openmpi/4.1.0
module load openmpi/2.1.1

PARENT_DIR="Cascade/city_block_cfd/CHARLES/config2"
LOCAL_FOLDER=$(basename "`pwd`")

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Executing charles from $(pwd)"

echo "0 0 0" > ./probes/VolProbe90X.svp
echo "0 0 0" > ./probes/VolProbe90Z.svp

source ~/.bash_profile
srun $OAK_HOME/$PARENT_DIR/charles/45_deg_4mps/charles.exe -i $OAK_HOME/$PARENT_DIR/$LOCAL_FOLDER/charles.in
# srun $OAK_HOME/$PARENT_DIR/../single_family/0_deg_spinnup2/charles.exe -i $OAK_HOME/$PARENT_DIR/$LOCAL_FOLDER/charles.in
