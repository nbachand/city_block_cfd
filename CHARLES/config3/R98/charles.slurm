#!/bin/bash
#SBATCH --job-name=cc3_R98
#SBATCH -n 24
#SBATCH --mem-per-cpu=7G
#SBATCH --time=7-00:00:00
#SBATCH --partition=serc
#SBATCH --mail-type=ALL
#SBATCH --constraint=[CLASS:SH4_CBASE|CLASS:SH4_CPERF|CLASS:SH3_CBASE.1]
export CTI_LICENSE=$HOME/Cascade/license.dat

module purge

module load system
module load libpng/1.2.57
# module load openmpi/4.1.0
module load openmpi/2.1.1

PARENT_DIR="Cascade/city_block_cfd/CHARLES/config3"
LOCAL_FOLDER=$(basename "`pwd`")

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "0 0 0" > ./probes/VolProbe90X.svp
echo "0 0 0" > ./probes/VolProbe90Z.svp

echo "Executing charles from $(pwd)"

source ~/.bash_profile
srun $OAK_HOME/$PARENT_DIR/charles/0_deg_2mps/charles.exe -i $OAK_HOME/$PARENT_DIR/$LOCAL_FOLDER/charles.in
