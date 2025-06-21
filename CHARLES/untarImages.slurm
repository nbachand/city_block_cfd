#!/bin/bash
#SBATCH --job-name="untarImages"
#SBATCH --output=untarImages.out
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=01:30:00
#SBATCH --mem=32G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL

# Source directory where the files are located
source_dir="$(pwd)"
. cd_scratch

tar_folder="$source_dir/Images.tar.gz"
echo "Untaring images from '$tar_folder' to '$(pwd)'"

tar -xzvf "$tar_folder" ./Images

echo "Untared Images"