#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <source_directory>"
  exit 1
fi

MTIMES_FILE="$1"

# Check if the mtimes file exists
if [ ! -f "$MTIMES_FILE" ]; then
  echo "Error: $MTIMES_FILE does not exist."
  exit 1
fi

# Restore mtimes with subsecond precision
while IFS='|' read -r file mtime; do
  if [ -f "$file" ]; then
    touch -d "$mtime" "$file"
  else
    echo "Warning: File $file does not exist and will be skipped."
  fi
done < "$MTIMES_FILE"

echo "Modification times restored from $MTIMES_FILE."
