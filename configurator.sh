#!/bin/bash
set -e  # Stop on error

# Configure GNOME Shell extensions
echo "Configuring GNOME Shell extensions..."
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true

# Add repositories and update
echo "Adding repositories and updating system..."
sudo add-apt-repository universe -y
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y

# Download and install packages
echo "Downloading and installing required packages..."
wget -O orthos-el_GR-0.4.0-87.oxt "https://downloads.sourceforge.net/project/orthos-spell/v.0.4.0./orthos-el_GR-0.4.0-87.oxt"
sudo apt install -y gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer shutter software-properties-common apt-transport-https libreoffice default-jdk filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg jupyter-notebook tesseract-ocr snapd gnome-sound-recorder

# Install VS Code and IntelliJ IDEA
echo "Installing Visual Studio Code and IntelliJ IDEA..."
sudo snap install code --classic
sudo snap install intellij-idea-community --classic --edge

# Install and configure Google Chrome
echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt install -f
rm google-chrome-stable_current_amd64.deb

# Activate Python virtual environment and install libraries
echo "Activating Python virtual environment and installing libraries..."
source ~/my_venv/bin/activate
pip3 install torch torchvision torchaudio ffprobe PyPDF2 SpeechRecognition urllib3 matplotlib beautifulsoup4 ffmpeg tk pygame phonenumbers python-docx openpyxl numpy customtkinter ctkmessagebox qrcode pandas requests Pillow pdf2image moviepy pyshorteners pdf2docx yt-dlp tabula-py pytesseract opencv-python folium rasterio punctuators
deactivate

# Set aliases and environment variables
echo "Setting aliases and environment variables..."
echo "export MAKEFLAGS=\"-j\$(nproc)\"" >> ~/.bashrc
echo "alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y'" >> ~/.bashrc
echo "alias connect='nordvpn connect'" >> ~/.bashrc
echo "alias disconnect='nordvpn disconnect'" >> ~/.bashrc
echo "alias pip='/home/rafail/run_pip.sh'" >> ~/.bashrc
echo "alias python='/home/rafail/run_python.sh'" >> ~/.bashrc

# Install and configure neovim
echo "Installing and configuring Neovim..."
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
nvim +qall  # Launches and closes Neovim to initialize configuration

# Reboot the system to apply all changes
echo "Rebooting system to apply all changes..."
sudo reboot