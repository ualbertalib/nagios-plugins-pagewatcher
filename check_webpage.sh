#!/bin/bash

# Check if arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <service_description> <url>"
    exit 3  # Nagios status code for "Unknown"
fi

# Assign input arguments to variables
SERVICE="$1"
URL="$2"

# Paths for storing checksums and webpage content
CHECKSUM_DIR="/var/tmp/nagios_check_webpage"
CHECKSUM_FILE="$CHECKSUM_DIR/$SERVICE.txt"
WEBPAGE_FILE="$CHECKSUM_DIR/$SERVICE.html"

# Ensure the directory exists
mkdir -p "$CHECKSUM_DIR"

# Check if the checksum file exists
if [ ! -f "$CHECKSUM_FILE" ]; then
    # If checksum file doesn't exist, create it with the initial checksum
    wget -q -O "$WEBPAGE_FILE" "$URL"
    sha256sum "$WEBPAGE_FILE" > "$CHECKSUM_FILE"
    echo "Initial checksum populated for $SERVICE"
    exit 0  # Nagios status code for "OK"
fi

# Download the webpage and calculate the checksum
wget -q -O "$WEBPAGE_FILE" "$URL"
NEW_CHECKSUM=$(sha256sum "$WEBPAGE_FILE" | awk '{print $1}')

# Compare with the stored checksum
OLD_CHECKSUM=$(awk '{print $1}' "$CHECKSUM_FILE")
if [ "$NEW_CHECKSUM" != "$OLD_CHECKSUM" ]; then
    echo "CRITICAL: $SERVICE webpage content has changed!"
    exit 2  # Nagios status code for "Critical"
else
    echo "OK: $SERVICE webpage content unchanged"
    exit 0  # Nagios status code for "OK"
fi
