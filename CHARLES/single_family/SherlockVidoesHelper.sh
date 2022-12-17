#!/bin/bash
module load system libglvnd/1.2.0
source ~/.bash_profile

PARENT_DIR="Cascade/city_block_cfd/CHARLES/single_family"
LOCAL_FOLDER=$(basename "`pwd`")

IMAGE_DIR=$SCRATCH/$PARENT_DIR/$LOCAL_FOLDER/Images

echo "Getting images from $(pwd)"

conda activate cascade_env

