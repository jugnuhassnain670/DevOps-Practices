#!/bin/bash

log_dir="/path/to/log/directory"
num_to_keep=5

cd "$log_dir"

# Compress and archive older logs
find . -name "*.log" -type f -printf '%T@ %p\n' | sort -n | head -n -$num_to_keep | while read -r log; do
    mv "$log" "$log.old"
    gzip "$log.old"
done

# Delete compressed logs older than a certain period
find . -name "*.gz" -type f -mtime +7 -delete
