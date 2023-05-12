#!/bin/bash
PARENT_DIR="Cascade/city_block_cfd/CHARLES"
CATEGORY=$(basename "`pwd`")
LOCAL_FOLDER=$1

# cd $SCRATCH/$PARENT_DIR/$CATEGORY/

echo "Creating folder in $(pwd)"

mkdir $LOCAL_FOLDER
mkdir $LOCAL_FOLDER/"plots"
mkdir $LOCAL_FOLDER/"Videos"
mkdir $LOCAL_FOLDER/"tables"

cd $SCRATCH/$PARENT_DIR/$CATEGORY/

echo "Creating folder in $(pwd)"

mkdir $LOCAL_FOLDER
mkdir $LOCAL_FOLDER/"data"
mkdir $LOCAL_FOLDER/"Images"
mkdir $LOCAL_FOLDER/"probes"
mkdir $LOCAL_FOLDER/"probes/probesOut"
mkdir $LOCAL_FOLDER"/probes/locations"

read -p "Optional: Enter run to copy probe locations from [skip]:" R_locations
R_locations="${R_locations:=skip}"
echo "$R_locations" # (optional) move to a new line
if [ "$R_locations" != "skip" ]; then
    cp -r ./$R_locations/probes/locations/* $LOCAL_FOLDER"/probes/locations"
fi