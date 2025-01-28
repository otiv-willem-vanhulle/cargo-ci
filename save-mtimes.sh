#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <destination_file>"
  exit 1
fi

MTIMES_FILE="$1"

# Check if the destination directory exists
if [ ! -f "$MTIMES_FILE" ]; then
  echo "Error: Destination directory does not exist."
  exit 1
fi


# Clear the file or create a new one
> "$MTIMES_FILE"

# Find all files tracked by git and save their mtimes with subsecond precision
git ls-files | while read -r file; do
  if [ -f "$file" ]; then
    mtime=$(stat --format='%y' "$file") # Capture mtime with subsecond precision
    echo "$file|$mtime" >> "$MTIMES_FILE"
  fi
done

echo "Modification times saved to $MTIMES_FILE."
