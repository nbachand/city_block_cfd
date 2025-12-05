#!/bin/bash
#SBATCH --job-name="tarFolder"
#SBATCH --output=tarFolder.out
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=01:30:00
#SBATCH --mem=32G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL


source_dir="$1"
tar_folder="$1.tar.gz"

echo "Tarring '$source_dir' to '$tar_folder'."
tar -czfv $tar_folder $source_dir
echo "Tarred '$source_dir' to '$tar_folder'."