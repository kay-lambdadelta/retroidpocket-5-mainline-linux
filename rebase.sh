#!/bin/bash

INPUT_DIR="$1"
OUTPUT_DIR="$2"

if [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

for patch in "$INPUT_DIR"/*.patch; do
    [ -e "$patch" ] || continue

    filename=$(basename "$patch")
    echo "Processing $filename..."

    if git am -C1 "$patch" >/dev/null 2>&1; then
        git format-patch -1 HEAD --stdout >"$OUTPUT_DIR/$filename"
    else
        echo "Failed: $filename required manual conflict resolution. Skipping."
        git am --abort >/dev/null 2>&1
    fi
done
