#!/bin/bash

source ~/.bash_profile

module purge

module load system
module load libpng/1.2.57
module load openmpi/4.1.0

module list

srun make
