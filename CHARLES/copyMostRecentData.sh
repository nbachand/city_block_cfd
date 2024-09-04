#!/bin/bash

# Source directory where the files are located
. cd_scratch
source_dir="$(pwd)/data"
locations_dir="$(pwd)/probes/locations"
cd -

# Destination directory where the largest file will be copied
destination_dir="./data/"

# Ensure the destination directory exists
mkdir -p "$destination_dir"

# Find the file with the largest number in its filename
largest_file=$(ls "$source_dir" | grep -E '.*\.[0-9]+\.sles$' | sort -t. -k2 -n | tail -n1)

# Copy the largest file to the destination directory
cp "$source_dir/$largest_file" "$destination_dir/"

echo "The most recent data file '$largest_file' has been copied to '$destination_dir'."

cp "$source_dir/result.00039000.sles" "$destination_dir/"
cp "$source_dir/result.00119000.sles" "$destination_dir/"
cp "$source_dir/result.00159000.sles" "$destination_dir/"

echo "Copied sles from important run transitions to '$destination_dir'."

cp -r "$locations_dir" "./probes/"

echo "Copied locations from '$locations_dir'."