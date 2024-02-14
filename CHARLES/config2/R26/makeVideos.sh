#!/bin/bash
source "../SherlockVidoesHelper.sh"

python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y1p5". --dt .01 --subsample 1
python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y3". --dt .01 --subsample 1
python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y12". --dt .01 --subsample 1
python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_z58". --dt .01 --subsample 1

# python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y10". --dt .01 --subsample 1

# python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_z265". --dt .01 --subsample 1

