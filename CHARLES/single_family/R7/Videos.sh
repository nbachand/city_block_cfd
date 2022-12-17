#!/bin/bash

source ../SherlockVidoesHelper.sh

cd ./Videos
echo "saving videos to: "
pwd

python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y5". --dt .075 --subsample 1
# python $PYCASCADE_PATH/png2video.py --directory ../Images --namefmt "u_y5". --dt 2 --subsample 1
# python $PYCASCADE_PATH/png2video.py --directory ../Images --namefmt "u_y8". --dt 2 --subsample 1
# python $PYCASCADE_PATH/png2video.py --directory ../Images --namefmt "u_y20". --dt 2 --subsample 1