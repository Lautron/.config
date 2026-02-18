#!/bin/bash

# Check if zbarcam is installed
if ! command -v zbarcam &> /dev/null; then
    notify-send "zbarcam could not be found. Please install zbar-tools."
    exit 1
fi

# Scan the QR code
notify-send "Please scan the QR code for the Wi-Fi credentials..."
QR_OUTPUT=$(zbarcam --raw -1 2>/dev/null)

# Check if the QR code was scanned successfully
if [ -z "$QR_OUTPUT" ]; then
    notify-send "No QR code detected. Exiting."
    exit 1
fi

# Parse the QR code output
SSID=$(echo "$QR_OUTPUT" | grep -oP 'S:\K[^;]+')
PASSWORD=$(echo "$QR_OUTPUT" | grep -oP 'P:\K[^;]+')
SECURITY_TYPE=$(echo "$QR_OUTPUT" | grep -oP 'T:\K[^;]+')

# Check if the required fields are extracted
if [[ -z "$SSID" || -z "$PASSWORD" || -z "$SECURITY_TYPE" ]]; then
    notify-send "Failed to parse the input string."
    exit 1
fi

# Connect to the Wi-Fi network
nmcli connection delete "$SSID"
if [[ "$SECURITY_TYPE" == "WPA" || "$SECURITY_TYPE" == "WPA2" ]]; then
    nmcli device wifi connect "$SSID" password "$PASSWORD"
    echo "nmcli device wifi connect $SSID password $PASSWORD"
else
    nmcli device wifi connect "$SSID"
fi

# Check if the connection was successful
if [[ $? -eq 0 ]]; then
    notify-send "Successfully connected to $SSID."
else
    notify-send "Failed to connect to $SSID."
fi
