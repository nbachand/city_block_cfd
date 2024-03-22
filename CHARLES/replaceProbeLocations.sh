#!/bin/bash
PARENT_DIR="Cascade/city_block_cfd/CHARLES"
LOCAL_FOLDER=$(basename "`pwd`")
R_copy=$1

. cd_scratch
echo "replacing locations in $(pwd)"
rm -r ./probes/locations
cp -r ../$R_copy/probes/locations "./probes/"

