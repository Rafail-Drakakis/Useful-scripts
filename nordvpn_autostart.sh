#!/bin/bash

# Define the service file path
SERVICE_FILE="/etc/systemd/system/nordvpn-startup.service"

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Create and write the service file
cat << EOF > $SERVICE_FILE
[Unit]
Description=Connect to NordVPN at startup
After=network-online.target

[Service]
Type=oneshot
Environment="HOME=/home/rafail"
ExecStart=/usr/bin/nordvpn connect
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to recognize the new service
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Restart the service
echo "Restarting nordvpn-startup.service..."
sudo systemctl restart nordvpn-startup.service

# Check the status of the service
echo "Checking the status of nordvpn-startup.service..."
sudo systemctl status nordvpn-startup.service
