#!/bin/bash

# Usage: ./copy_from_scratch.sh "relative/path/to/image*.png" 1 2 3

if [ $# -lt 2 ]; then
    echo "Usage: $0 <image_path_pattern> <run_number1> [run_number2 ...]"
    exit 1
fi

IMAGE_PATH_PATTERN="$1"
shift
RUN_NUMBERS=("$@")

# Save current directory to return to later
SOURCE_DIR="$(pwd)"
# mkdir "./temp_images"

# Change to scratch (assumes cd_scratch is a sourced function or alias)
. cd_scratch || { echo "Failed to enter scratch directory"; exit 1; }

echo "Current directory: $(pwd)"

# Loop over run numbers
for RUN in "${RUN_NUMBERS[@]}"; do
    SEARCH_DIR="R${RUN}/Images"
    
    # Use find to resolve the glob pattern inside the proper directory
    MATCHES=($(find "$SEARCH_DIR" -path "$SEARCH_DIR/$IMAGE_PATH_PATTERN"))

    for FILE in "${MATCHES[@]}"; do
        # Strip the leading directory for relative path
        REL_PATH="${FILE#$SEARCH_DIR/}"

        # Format destination path — flattening to avoid subdirs
        DEST_NAME="R${RUN}_${REL_PATH//\//_}"

        # Copy back to the original directory
        cp "$FILE" "$SOURCE_DIR/temp_images/$DEST_NAME"
        echo "Copied $FILE -> temp_images/$DEST_NAME"
    done
done

# Return to the original directory (optional)
cd "$SOURCE_DIR"