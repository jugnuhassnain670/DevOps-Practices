#!/bin/bash

directory="/e/ScriptTest"
threshold_size=$((1024 * 1024 * 1024)) # 1GB in bytes
current_size=$(du -s "$directory" | awk '{print $1}')
if [ "$current_size" -gt "$threshold_size" ]; then
    
    echo "Directory size exceeded 1GB: $current_size bytes"
    url="https://app.whistleit.io/api/webhooks/64d1c24d14d13578b2208536"
    message="Directory size exceeded 1GB: $current_size bytes"
    curl -X POST -d "message=$message" "$url"
    # Send a notification (e.g., email, SMS, or any preferred method)
else
    echo "Directory size is within limit: $current_size bytes"
fi


# webhook_url="https://app.whistleit.io/api/webhooks/64d1f8fc602e1e5d893bc831"
# message_data='{"text": "This is a text message"}'

# # Send the webhook request using curl
# curl -X POST -H "Content-Type: application/json" -d "$message_data" "$webhook_url"
