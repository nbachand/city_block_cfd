#!/bin/bash
# call from run folder
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
python resultsToParquet.py $RUN $CATEGORY "FLUX_PROBES"
