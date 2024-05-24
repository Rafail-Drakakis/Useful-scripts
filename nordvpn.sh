#!/bin/bash

# Check if the script is being run using bash or not
if [ -z "$BASH_VERSION" ]; then
    echo "This script requires Bash. Please run it using './nordvpn.sh' or 'bash nordvpn.sh'." >&2
    exit 1
fi

set -euo pipefail

# Define constants
NORDVPN_URL="https://downloads.nordcdn.com/apps/linux/install.sh"
SERVICE_FILE="/etc/systemd/system/nordvpn-startup.service"
SERVICE_CONTENT="[Unit]
Description=Connect to NordVPN at startup
After=network-online.target

[Service]
Type=oneshot
Environment=\"HOME=$HOME\"
ExecStart=/usr/bin/nordvpn connect
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target"

# Helper functions
install_nordvpn() {
    echo "Starting the installation of NordVPN..."
    if sh <(curl -sSf ${NORDVPN_URL}); then
        echo "Installation successful."
        sudo usermod -aG nordvpn "$USER"
    else
        echo "Installation failed." >&2
        exit 1
    fi
}

setup_nordvpn() {
    echo "Please log in to NordVPN"
    nordvpn login
    read -p "Press [Enter] once you have authenticated in the browser..."
    nordvpn connect
    echo "$SERVICE_CONTENT" | sudo tee "$SERVICE_FILE" > /dev/null
    echo "Reloading systemd daemon..."
    sudo systemctl daemon-reload
    echo "Enabling and starting nordvpn-startup.service..."
    sudo systemctl enable --now nordvpn-startup.service
    echo "Checking the status of nordvpn-startup.service..."
    sudo systemctl status nordvpn-startup.service

}

# Check the input argument
ARG="${1:-}"
case "$ARG" in
    install)
        install_nordvpn
        echo "Please reboot your system to apply changes."
        ;;
    setup)
        setup_nordvpn
        ;;
    *)
        echo "Usage: $0 {install|setup}"
        echo "No argument provided. Exiting."
        exit 1
        ;;
esac
