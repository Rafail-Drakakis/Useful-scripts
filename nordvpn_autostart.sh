#!/bin/bash

# Define the service file path
SERVICE_FILE="/etc/systemd/system/nordvpn-startup.service"

# Prepare the content of the service file
SERVICE_CONTENT="[Unit]
Description=Connect to NordVPN at startup
After=network-online.target

[Service]
Type=oneshot
Environment=\"HOME=/home/rafail\"
ExecStart=/usr/bin/nordvpn connect
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target"

# Create and write the service file using sudo for elevated privileges
echo "$SERVICE_CONTENT" | sudo tee $SERVICE_FILE > /dev/null

# Reload systemd to recognize the new service
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Restart the service
echo "Restarting nordvpn-startup.service..."
sudo systemctl restart nordvpn-startup.service

# Check the status of the service
echo "Checking the status of nordvpn-startup.service..."
sudo systemctl status nordvpn-startup.service

echo "Press ctr + c"
