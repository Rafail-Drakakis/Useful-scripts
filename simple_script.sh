# Ubuntu logistics
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM # Move taskbar to bottom
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true # Move the "show applications key to the right"
sudo apt install gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer -y # Install gnome-tweaks and microsoft fonts

# Install Google Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb # Download the .deb file
sudo dpkg -i google-chrome-stable_current_amd64.deb # Install google chrome
rm google-chrome-stable_current_amd64.deb # Remove the file

# Install software
sudo apt install software-properties-common apt-transport-https filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg yt-dlp jupyter tesseract-ocr snapd gnome-sound-recorder -y

# Set up aliases for frequently used commands
echo "MAKEFLAGS= \"-J$(nproc)\"" # This command sets the number of jobs make can run simultaneously

# Final system update
sudo apt-get update -y # Update the system
sudo apt-get upgrade -y # Upgrade the system
sudo apt-get dist-upgrade -y # Upgrade the distribution
sudo reboot # Reboot the system