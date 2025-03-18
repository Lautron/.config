#!/bin/bash
# Define the sink to ignore
ignore_sink="alsa_output.pci-0000_00_1f.3.iec958-stereo"
# Get the list of sinks, excluding the ignored sink
sinks=($(pactl list short sinks | awk '{print $2}' | grep -v "$ignore_sink"))
# Check if there are any sinks available after filtering
if [ ${#sinks[@]} -eq 0 ]; then
    notify-send "Audio Sink Change Error" "No available sinks to switch to."
    exit 1
fi
# Get the current sink
current_sink=$(pactl get-default-sink)
# Find the index of the current sink, ignoring the ignored sink
current_index=-1
for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done
# Calculate the next sink index
if [ $current_index -eq -1 ]; then
    # If the current sink is not found in the filtered list, default to the first sink
    next_index=0
else
    next_index=$(( (current_index + 1) % ${#sinks[@]} ))
fi
# Get the next sink name
next_sink=${sinks[$next_index]}
# Switch to the next sink
pactl set-default-sink "$next_sink"
# Send a notification
notify-send "Audio Sink Changed" "Switched to sink: $next_sink"
# Optional: You can also print to the terminal
echo "Switched to sink: $next_sink"

