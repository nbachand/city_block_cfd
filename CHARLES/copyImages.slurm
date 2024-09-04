#!/bin/bash
#SBATCH --job-name="copyImages"
#SBATCH --output=copyImages.out
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=01:30:00
#SBATCH --mem=32G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL

# Source directory where the files are located
. cd_scratch
source_dir="$(pwd)"
tar_folder="./Images.tar.gz"
tar -czf "$tar_folder" ./Images
cd -

echo "Tarred Images from '$source_dir'."

# Copy the largest file to the destination directory
mv "$source_dir/$tar_folder" ./

echo "Copied tarred Images from '$source_dir'."