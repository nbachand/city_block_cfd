#!/bin/bash
# Source directory where the files are located
source_dir="$(pwd)"
. cd_scratch

data_folder="$source_dir/data"
echo "Linking data from '$data_folder' to '$(pwd)'"

ln -sfn "$data_folder" ./data

echo "Data linked successfully"