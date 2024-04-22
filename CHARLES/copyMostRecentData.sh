#!/bin/bash

# Source directory where the files are located
. cd_scratch
source_dir="$(pwd)/data"
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

