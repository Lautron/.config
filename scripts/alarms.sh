#!/bin/bash

# Read file line by line
while IFS= read -r line; do
    # Split the line by space and get the hour and comment
    hour=$(echo "$line" | awk '{print $1}')
    comment=$(echo "$line" | cut -d " " -f 2-)

    # Schedule the task using 'at'
    set-alarm $hour "$comment"
done < "$HOME/.config/scripts/alarms.txt"
