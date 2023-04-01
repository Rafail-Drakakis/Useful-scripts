#!/bin/bash

#Ubuntu logistics
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM # Move taskbar to bottom
sudo apt install gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer -y # Install gnome-tweaks and microsoft fonts

# Install Google Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb 
rm google-chrome-stable_current_amd64.deb

# Install software
sudo apt install software-properties-common apt-transport-https filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg yt-dlp jupyter -y
sudo snap install notepad-plus-plus code -y
pip install numpy pandas matplotlib requests beautifulsoup4 pygame pytube openpyxl 

# Set up aliases for frequently used commands
echo "alias jupyter='jupyter notebook'" >> ~/.bashrc # Enter jupyter instead of jupyter notebook
echo "alias google='google-chrome'" >> ~/.bashrc # Enter google instead of google-chrome
echo "alias python='python3'" >> ~/.bashrc
echo "alias pip='pip3'" >> ~/.bashrc
echo "MAKEFLAGS= \"-J$(nproc)\"" # This command sets the number of jobs make can run simultaneously

# Final system update
sudo apt-get update -y # Update the system
sudo apt-get upgrade -y # Upgrade the system
sudo apt-get dist-upgrade -y # Upgrade the distribution

