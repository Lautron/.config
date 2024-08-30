#!/bin/bash
# Get the list of sinks and display them
echo "Available sinks:"
pactl list short sinks
# Prompt the user to enter the sink ID they want to set as default
read -p "Enter the sink ID you want to set as default: " SINK_ID
# Check if the entered sink ID is valid
if pactl list short sinks | grep -q "^$SINK_ID"; then
    # Set the default sink
    pactl set-default-sink "$SINK_ID"
    echo "Default sink set to: $SINK_ID"
else
    echo "Invalid sink ID: $SINK_ID"
    exit 1
fi
