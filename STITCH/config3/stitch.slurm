#!/bin/bash
#SBATCH --job-name=stitch
#SBATCH -c 1
#SBATCH -N 2
#SBATCH -n 64
#SBATCH --time=01:00:00
#SBATCH --mem=192G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL
#SBATCH --constraint="[CLASS:SH3_CBASE|CLASS:SH3_CBASE.1|CPU_GEN:SKX]" 

source ~/.bash_profile

module purge

module load system
module load libpng/1.2.57
module load openmpi/2.1.1

STITCH_DIR="Cascade/city_block_cfd/STITCH"
LOCAL_FOLDER=$(basename "`pwd`")
SURFER_DIR="Cascade/city_block_cfd/city_block_geom/SURFER"

# mkdir $SCRATCH/$SURFER_DIR/$LOCAL_FOLDER
# mkdir $SCRATCH/$STITCH_DIR/$LOCAL_FOLDER

# cp $OAK_HOME/$SURFER_DIR/$LOCAL_FOLDER/* $SCRATCH/$SURFER_DIR/$LOCAL_FOLDER/ 

# cd $SCRATCH/$STITCH_DIR/$LOCAL_FOLDER

echo "Executing stitch from $(pwd)"

# mpiexec stitch.exe -i $OAK_HOME/$STITCH_DIR/$LOCAL_FOLDER/stitch-OSX.in
# mpiexec stitch.exe -i $OAK_HOME/$STITCH_DIR/$LOCAL_FOLDER/stitch.in
mpiexec stitch.exe -i $OAK_HOME/$STITCH_DIR/$LOCAL_FOLDER/stitch-course.in
# mpiexec stitch.exe -i $OAK_HOME/$STITCH_DIR/$LOCAL_FOLDER/stitch-fine.in
