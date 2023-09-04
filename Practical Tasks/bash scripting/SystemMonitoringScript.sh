#!/bin/bash

threshold_cpu=90
threshold_memory=90

while true; do
    cpu_usage=$(top -bn 1 | awk '/Cpu/ {print 100 - $8}')
    memory_usage=$(free | awk '/Mem:/ {print $3/$2 * 100}')

    if (( $(echo "$cpu_usage >= $threshold_cpu" | bc -l) )); then
        echo "High CPU usage: $cpu_usage%"
        # Send an alert (e.g., email or notification)
    fi

    if (( $(echo "$memory_usage >= $threshold_memory" | bc -l) )); then
        echo "High memory usage: $memory_usage%"
        # Send an alert (e.g., email or notification)
    fi

    sleep 300  # Check every 5 minutes
done
