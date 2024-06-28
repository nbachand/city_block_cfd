#!/bin/bash
#SBATCH --job-name="getParquet"
#SBATCH --output=getParquet.out
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=00:30:00
#SBATCH --mem=32G
#SBATCH --partition=serc
#SBATCH --mail-type=ALL

# call from run folder

start_time=$(date +%s)
module load system
module load openmpi/4.1.0

source ~/.bash_profile

PARENT_DIR="Cascade/city_block_cfd/CHARLES/"
LOCAL_FOLDER=$(basename "`pwd`")
cd ..
CATEGORY=$(basename "`pwd`")
echo $CATEGORY
RUN=${LOCAL_FOLDER:1:3}
echo $RUN

cp -rf "$SCRATCH/$PARENT_DIR/$CATEGORY/R$RUN/probes/locations" "$OAK_HOME/$PARENT_DIR/$CATEGORY/R$RUN/probes/"

cd ../..
pwd
conda activate pycascade
python resultsToParquet.py $RUN $CATEGORY "FLUX_PROBES"
python resultsToParquet.py $RUN $CATEGORY "PROBES"
python resultsToParquet.py $RUN $CATEGORY "VOLUMETRIC_PROBES"
end_time=$(date +%s)

# Calculate the elapsed time
elapsed_time=$((end_time - start_time))

echo "Elapsed time: $elapsed_time seconds"