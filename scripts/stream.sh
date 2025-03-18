kdeconnect-app &
echo 1
kill $(pgrep reddit_notifs)&
echo 2

systemctl --user stop night_routine

SINKS=$(pactl list short sinks | awk '{print $1, $2}' | grep "hdmi")

# Check if the user selected a sink
if [ -z "$SINKS" ]; then
    echo "No sink selected."
    exit 1
fi

# Extract the sink ID from the selected sink
SINK_ID=$(echo "$SINKS" | awk '{print $1}')

# Set the default sink
pactl set-default-sink "$SINK_ID"
echo 3
notify-send "Default sink set to hdmi"
echo 4
stremio

