#!/bin/bash
module load system libglvnd/1.2.0
source ~/.bash_profile
conda activate pycascade

PARENT_DIR="Cascade/city_block_cfd/CHARLES/config2"
LOCAL_FOLDER=$(basename "`pwd`")

IMAGE_DIR=$SCRATCH/$PARENT_DIR/$LOCAL_FOLDER/Images/images_rescaled/
echo "Getting images from $IMAGE_DIR"

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER
mkdir "./Videos"
cd "./Videos"
echo "Saving videos in $(pwd)"

conda activate pycascade

