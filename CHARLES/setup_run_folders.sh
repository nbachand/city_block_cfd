#!/bin/bash
PARENT_DIR="Cascade/city_block_cfd/CHARLES"
CATEGORY=$(basename "`pwd`")
LOCAL_FOLDER=$1

# cd $SCRATCH/$PARENT_DIR/$CATEGORY/

echo "Creating folder in $(pwd)"

read -p "Optional: Enter run to copy from [skip]:" R_copy
R_copy="${R_copy:=skip}"

echo "$R_copy" # (optional) move to a new line
mkdir $LOCAL_FOLDER
mkdir $LOCAL_FOLDER/"plots"
mkdir $LOCAL_FOLDER/"Videos"
mkdir $LOCAL_FOLDER/"tables"
if [ "$R_copy" != "skip" ]; then
    cp ./$R_copy/charles* $LOCAL_FOLDER"/"
    cp ./$R_copy/*.sh $LOCAL_FOLDER"/"
fi

cd $SCRATCH/$PARENT_DIR/$CATEGORY/

echo "Creating folder in $(pwd)"

mkdir $LOCAL_FOLDER
mkdir $LOCAL_FOLDER/"data"
mkdir $LOCAL_FOLDER/"Images"
mkdir $LOCAL_FOLDER/"probes"
mkdir $LOCAL_FOLDER/"probes/probesOut"
mkdir $LOCAL_FOLDER"/probes/locations"

if [ "$R_copy" != "skip" ]; then
    cp -r ./$R_copy/probes/locations/* $LOCAL_FOLDER"/probes/locations"
    cp ./$R_copy/*.txt $LOCAL_FOLDER"/"
fi
