module purge

module load system
module load libpng/1.2.57
module load openmpi/2.1.1

module list

source ~/.bash_profile

make
