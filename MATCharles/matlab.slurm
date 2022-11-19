#!/bin/bash
#SBATCH --job-name=matcharles
#SBATCH --output=matcharles."%j".out
#SBATCH --error=matcharles."%j".err
#SBATCH --partition=normal
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH -n 8
#SBATCH -N 1
#SBATCH --mail-type=ALL

module load matlab
matlab -nodisplay < LESResults.m
