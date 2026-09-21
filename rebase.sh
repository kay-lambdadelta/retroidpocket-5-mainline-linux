#!/bin/bash

INPUT_DIR="$1"
LINUX_DIR="$2"

if [ -z "$INPUT_DIR" ] || [ -z "$LINUX_DIR" ]; then
    echo "Usage: $0 <input_dir> <linux_dir>"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_DIR="$(cd "$INPUT_DIR" && pwd)"
LINUX_DIR="$(cd "$LINUX_DIR" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/patches-rebased"

mkdir -p "$OUTPUT_DIR"
cd "$LINUX_DIR" || exit 1

for patch in "$INPUT_DIR"/*.patch; do
    [ -e "$patch" ] || continue

    filename=$(basename "$patch")
    echo "Processing $filename..."

    if git am -3 "$patch"; then
        git format-patch -1 HEAD --stdout >"$OUTPUT_DIR/$filename"
    else
        echo "Failed: $filename required manual conflict resolution. Skipping."
        git am --abort >/dev/null 2>&1
    fi
done
