folder="/var/project"
log_file="/var/project/log.txt"

getHashes(){
    echo "sha256sum $folder/* | awk '{ print $1 }'"
}

while true
do
    for file in $directory/*
    do
        # to get the modified time and hash of the file
        checksum=$(md5sum "$file" | awk '{ print $1 }')
        modified_time=$(stat -c %Y "$file")

        # to check if the file is modified 
        if [[ $checksum != $(grep "$file" "$log_file" | awk '{ print $2 }') ]]
        then
            # To print the name and time of the file
            echo "File modified: $file, Modified time: $(date -d @$modified_time)"
