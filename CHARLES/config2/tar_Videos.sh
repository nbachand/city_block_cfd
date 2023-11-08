#!/bin/bash
module load system
module load openmpi/4.1.0

source ~/.bash_profile

PARENT_DIR="Cascade/city_block_cfd/CHARLES/config2"
LOCAL_FOLDER=$(basename "`pwd`")

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Taring videos in $(pwd)"

srun tar -czvf ./Videos.tar.gz ./Videos

