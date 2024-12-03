#!/bin/bash

# Get the list of sinks and format it for dmenu
SINKS=$(pactl list short sinks | awk '{print $1, $2}' | dmenu -i -p "Select a sink:")

# Check if the user selected a sink
if [ -z "$SINKS" ]; then
    echo "No sink selected."
    exit 1
fi

# Extract the sink ID from the selected sink
SINK_ID=$(echo "$SINKS" | awk '{print $1}')

# Set the default sink
pactl set-default-sink "$SINK_ID"
echo "Default sink set to: $SINK_ID"
