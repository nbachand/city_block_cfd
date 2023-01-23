#!/bin/bash
PARENT_DIR="Cascade/city_block_cfd/CHARLES/single_family"
LOCAL_FOLDER=$1

cd $SCRATCH/$PARENT_DIR/$LOCAL_FOLDER

echo "Clearing results in folder in $(pwd)"

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    rm ./result.*
    rm ./data/*
    rm ./Images/*
    rm ./probes/probesOut/*
fi
