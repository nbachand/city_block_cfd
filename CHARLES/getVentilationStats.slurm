#!/bin/bash
#SBATCH --job-name="getVentilationStats"
#SBATCH --output=getVentilationStats.out
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --time=04:00:00
#SBATCH --mem=96G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL

# call from run folder

start_time=$(date +%s)
module load system
module load openmpi/4.1.0

source ~/.bash_profile

LOCAL_FOLDER=$(basename "`pwd`")
cd ..
CATEGORY=$(basename "`pwd`")
echo $CATEGORY
RUN=${LOCAL_FOLDER:1:3}
echo $RUN

cd ../..
pwd
conda activate pycascade
python getVentilationStats.py $CATEGORY $RUN "POINTCLOUD_PROBES" "40000," "119000,"
# python getVentilationStats.py $CATEGORY $RUN "FLUX_PROBES" "40000,120000,160000" "120000,160000,240000"
# python getVentilationStats.py $CATEGORY $RUN "FLUX_PROBES" "30000," "70000,"
end_time=$(date +%s)

# Calculate the elapsed time
elapsed_time=$((end_time - start_time))

echo "Elapsed time: $elapsed_time seconds"