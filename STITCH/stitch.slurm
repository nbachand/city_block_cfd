#!/bin/bash
#SBATCH --jobname=stitch

module purge

module load system
module load libpng/1.2.57
module load devel
module load impi/2018

stitch.exe -i stitch_paper.in