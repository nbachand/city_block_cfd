#!/bin/bash
##SBATCH --job-name=videos
#SBATCH --time=01:05:00
#SBATCH --mem=8G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL

source "../SherlockVidoesHelper.sh"

# python $PYCASCADE_PATH/png2video.py --directory "$IMAGE_DIR/images_rescaled" --namefmt "u_y1p5". --fps 30 --subsample 1 --output "u_y1p5.avi"
# python $PYCASCADE_PATH/png2video.py --directory "$IMAGE_DIR/images_rescaled" --namefmt "u_y3".   --fps 30 --subsample 1 --output "u_y3.avi"  
# python $PYCASCADE_PATH/png2video.py --directory "$IMAGE_DIR/images_rescaled" --namefmt "u_y12".  --fps 30 --subsample 1 --output "u_y12.avi" 
# python $PYCASCADE_PATH/png2video.py --directory "$IMAGE_DIR/images_rescaled" --namefmt "u_z58".  --fps 30 --subsample 1 --output "u_z58.avi" 

# python $PYCASCADE_PATH/png2video.py --directory "$IMAGE_DIR/images_rescaled" --namefmt "D_h_0-1_Bxz".  --fps 30 --subsample 1 --output "D_h_0-1_Bxz.avi" 
python $PYCASCADE_PATH/png2video.py --directory "$IMAGE_DIR/images_rescaled" --namefmt "u_h_0-1_Bxz".  --fps 30 --subsample 1 --output "u_h_0-1_Bxz.avi" 