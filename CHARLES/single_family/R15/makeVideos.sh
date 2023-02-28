#!/bin/bash
module load system libglvnd/1.2.0
source ~/.bash_profile

PARENT_DIR="Cascade/city_block_cfd/CHARLES/single_family"
LOCAL_FOLDER=$(basename "`pwd`")

IMAGE_DIR=$SCRATCH/$PARENT_DIR/$LOCAL_FOLDER/Images

echo "Getting images from $IMAGE_DIR"

conda activate cascade_env

python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y2". --dt .1 --subsample 1

