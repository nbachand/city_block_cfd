#!/bin/bash
##SBATCH --job-name=videos
#SBATCH --time=01:05:00
#SBATCH --mem=8G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL

source "../SherlockVidoesHelper.sh"

$CTI_HOME/bin/ping_s.exe --IMAGES "$IMAGE_DIR"/u_y1p5*.png --RESCALE GLOBAL LOOSE PATH "$IMAGE_DIR/video_images"
python $PYCASCADE_PATH/png2video.py --directory "$IMAGE_DIR/video_images" --namefmt "u_y1p5". --fps 10 --subsample 1 --output "u_y1p5.avi"
# python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y3". --dt .01 --subsample 1
# python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y12". --dt .01 --subsample 1
# python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_z265". --dt .01 --subsample 1

# python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_y10". --dt .01 --subsample 1

# python $PYCASCADE_PATH/png2video.py --directory $IMAGE_DIR --namefmt "u_z265". --dt .01 --subsample 1

