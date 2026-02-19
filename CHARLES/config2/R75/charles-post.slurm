#!/bin/bash
#SBATCH --job-name=cc2_posty
#SBATCH --output=post.out
#SBATCH -N 2
#SBATCH -n 16
#SBATCH --time=00:02:00
#SBATCH --mem 64G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL
export CTI_LICENSE=$HOME/Cascade/license.dat

module purge

module load system
module load libpng/1.2.57
# module load openmpi/4.1.0
module load openmpi/2.1.1

PARENT_DIR="Cascade/city_block_cfd/CHARLES/"
LOCAL_FOLDER=$(basename "`pwd`")
cd ..
CATEGORY=$(basename "`pwd`")
echo $CATEGORY
RUN=${LOCAL_FOLDER:1:3}
echo $RUN

cd ../..

cd $SCRATCH/$PARENT_DIR/$CATEGORY/$LOCAL_FOLDER

echo "Executing charles from $(pwd)"

# echo "Clearing old Vol Probes"
# rm ./probes/probesOut/VolProbe*.svp

# source ~/.bash_profile
srun $OAK_HOME/$PARENT_DIR/$CATEGORY/charles/0_deg_4mps/charles.exe -i $OAK_HOME/$PARENT_DIR/$CATEGORY/$LOCAL_FOLDER/charles-post.in