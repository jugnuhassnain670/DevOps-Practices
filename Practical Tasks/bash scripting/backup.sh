# Automated Backup Script

#!/bin/bash

source_dir="/path/to/source/directory"
backup_dir="/path/to/backup/location"
backup_date=$(date +"%Y%m%d")

tar -czvf "$backup_dir/backup_$backup_date.tar.gz" "$source_dir"





source_dir="/home/hassnain/Documents"
backup_dir="/home/hassnain/BDocuments"
backup_date=$(date +"%y%m%d")
tar -czvf "$backup_dir/backup_$backup_date.tar.gz" "$source_dir"

#!/bin/bash

backup_folder="/path/to/backup/folder"
backup_prefix="backup_"

# Count the number of backup files
backup_count=$(find "$backup_folder" -maxdepth 1 -type f -name "${backup_prefix}*" | wc -l)

# Define the maximum number of backup files before deletion
max_backup_count=8

if [ "$backup_count" -ge "$max_backup_count" ]; then
    # Get the oldest backup file and delete it
    oldest_backup=$(ls -t "$backup_folder"/"${backup_prefix}"* | tail -1)
    rm "$oldest_backup"
    echo "Deleted oldest backup: $oldest_backup"
else
    echo "Backup count is below the limit. No deletion needed."
fi





#!/bin/bash

# Source directory to be backed up
source_dir="/home/hassnain/Documents"

# Backup directory
backup_dir="/home/hassnain/BDocuments/DailyBackup"
weekly_dir="/home/hassnain/BDocuments/WeekBackups"

# Maximum number of backup files to retain
max_backup_count=8

# Create backup filename with timestamp
backup_filename="backup_$( date +'%Y-%m-%d %H:%M:%S').tar.gz"

# Perform backup
tar -czf "$backup_dir/$backup_filename" "$source_dir"

# Count the number of backup files in the backup directory
backup_count=$(ls "$backup_dir" | grep -c "backup_")

if [ "$backup_count" -gt "$max_backup_count" ]; then
    # Get the oldest backup file and delete it
    oldest_backup=$(ls -t "$backup_dir" | grep "backup_" | tail -1)
    cp "$backup_dir/$oldest_backup" "$weekly_dir"
    rm "$backup_dir/$oldest_backup" 
    echo "Deleted oldest backup: $oldest_backup"
fi

echo "Backup completed. Total backup files: $backup_count"
