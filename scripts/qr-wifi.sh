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
if [[ -z "$SSID" || -z "$PASSWORD" ]]; then
    notify-send "Failed to parse. SSID or password missing."
    exit 1
fi

# Connect to the Wi-Fi network
nmcli device wifi rescan
sleep 3

NETWORK_INFO=$(nmcli -t -f SSID,SECURITY dev wifi list | grep -i "^$SSID:")
if [[ -z "$NETWORK_INFO" ]]; then
    notify-send "Network '$SSID' not found in scan"
    exit 1
fi

ACTUAL_SSID=$(echo "$NETWORK_INFO" | cut -d: -f1 | xargs)
SECURITY_SCAN=$(echo "$NETWORK_INFO" | cut -d: -f2-)

echo "SSID: '$ACTUAL_SSID', Security: '$SECURITY_SCAN'"

nmcli connection delete "$ACTUAL_SSID" 2>/dev/null
sleep 1

if echo "$SECURITY_SCAN" | grep -q "WPA2"; then
    nmcli connection add type wifi con-name "$ACTUAL_SSID" ifname wlan0 ssid "$ACTUAL_SSID" \
        wifi-sec.key-mgmt wpa-psk wifi-sec.psk "$PASSWORD" wifi-sec.proto rsn
elif echo "$SECURITY_SCAN" | grep -q "WPA1"; then
    nmcli connection add type wifi con-name "$ACTUAL_SSID" ifname wlan0 ssid "$ACTUAL_SSID" \
        wifi-sec.key-mgmt wpa-psk wifi-sec.psk "$PASSWORD" wifi-sec.proto wpa
else
    nmcli connection add type wifi con-name "$ACTUAL_SSID" ifname wlan0 ssid "$ACTUAL_SSID"
fi

nmcli connection up id "$ACTUAL_SSID"

# Check if the connection was successful
if [[ $? -eq 0 ]]; then
    notify-send "Successfully connected to $SSID."
else
    notify-send "Failed to connect to $SSID."
fi
