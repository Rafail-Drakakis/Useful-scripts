# Ubuntu logistics
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM # Move taskbar to bottom
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true # Move the "show applications key to the right"
sudo apt install gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer -y # Install gnome-tweaks and microsoft fonts
wget https://sourceforge.net/projects/orthos-spell/files/v.0.4.0./orthos-el_GR-0.4.0-87.oxt # Install orthos.oxt, a Greek dictionary for Libre Office

# Install Google Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb # Download the .deb file
sudo dpkg -i google-chrome-stable_current_amd64.deb # Install google chrome
rm google-chrome-stable_current_amd64.deb # Remove the file

# Install software
sudo apt install software-properties-common apt-transport-https copyq wget python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg yt-dlp jupyter tesseract-ocr snapd gnome-sound-recorder -y
pip install pyinstaller

# Set up aliases for frequently used commands
echo "MAKEFLAGS= \"-J$(nproc)\"" # This command sets the number of jobs make can run simultaneously
echo "alias update='sudo apt-get update -y'" >> ~/.bashrc # Type "update" instead of "sudo apt-get update -y"
echo "alias upgrade='sudo apt-get upgrade -y'" >> ~/.bashrc # Type "upgrade" instead of "sudo apt-get upgrade -y"
echo "alias suspend='systemctl suspend'" >> ~/.bashrc # TYpe "suspend" instead of systemctl suspend

# Final system update
sudo apt-get update -y # Update the system
sudo apt-get upgrade -y # Upgrade the system
sudo apt-get dist-upgrade -y # Upgrade the distribution
sudo reboot # Reboot the system
