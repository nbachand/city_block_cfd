#!/bin/bash
source "../SherlockVidoesHelper.sh"

cd ./Videos

python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y5". --dt .01 --subsample 1

python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y10". --dt .01 --subsample 1

python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_z265". --dt .01 --subsample 1

