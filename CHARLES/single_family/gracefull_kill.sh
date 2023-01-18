#!/bin/bash
PARENT_DIR="Cascade/city_block_cfd/CHARLES/single_family"
LOCAL_FOLDER=$1

echo "Creating folder in $(pwd)"

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Killing Charles in $(pwd)"
echo "stab stab stab"

echo 'stop' > ./killcharles

echo "thunk"
