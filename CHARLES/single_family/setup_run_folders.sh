#!/bin/bash
PARENT_DIR="Cascade/city_block_cfd/CHARLES/single_family"
LOCAL_FOLDER=$1

echo "Creating folder in $(pwd)"

mkdir $LOCAL_FOLDER
mkdir $LOCAL_FOLDER/"plots"
mkdir $LOCAL_FOLDER/"Videos"

# cd $SCRATCH/$PARENT_DIR/

# echo "Creating folder in $(pwd)"

mkdir $LOCAL_FOLDER
mkdir $LOCAL_FOLDER/"data"
mkdir $LOCAL_FOLDER/"Images"
mkdir $LOCAL_FOLDER/"probes"
mkdir $LOCAL_FOLDER/"probes/locations"
mkdir $LOCAL_FOLDER/"probes/probesOut"