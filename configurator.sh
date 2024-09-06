#!/bin/bash

set -e  # Stop on error

# Configure GNOME Shell extensions
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true

# Add repositories and update
sudo add-apt-repository universe -y || true  # Continue even if repository addition fails
sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade

# Download and install packages
wget -O orthos-el_GR-0.4.0-87.oxt "https://downloads.sourceforge.net/project/orthos-spell/v.0.4.0./orthos-el_GR-0.4.0-87.oxt"
sudo apt install -y gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer shutter software-properties-common apt-transport-https libreoffice default-jdk filezilla copyq wget python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg jupyter-notebook tesseract-ocr snapd gnome-sound-recorder python3-venv

# Install VS Code and IntelliJ IDEA
sudo snap install code --classic
sudo snap install intellij-idea-community --classic --edge

# Install and configure Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt install -f
rm google-chrome-stable_current_amd64.deb

# Define the path to the virtual environment
VENV_PATH="$HOME/my_venv"

# Create or recreate virtual environment
python3 -m venv "$VENV_PATH"

# Activate the virtual environment
. "$VENV_PATH/bin/activate"

# Install Python libraries
pip install torch torchvision torchaudio ffprobe PyPDF2 SpeechRecognition urllib3 matplotlib beautifulsoup4 ffmpeg tk pygame python-docx openpyxl numpy customtkinter ctkmessagebox qrcode pandas requests Pillow pdf2image moviepy pyshorteners pdf2docx yt-dlp tabula-py pytesseract opencv-python folium rasterio punctuators

# Deactivate the virtual environment
deactivate

# Define the functions to add to .bashrc
functions_to_add=$(cat <<'EOF'
run_python() {
    source /home/rafail/my_venv/bin/activate
    python3 "$@"
    deactivate
}

run_pip() {
    source /home/rafail/my_venv/bin/activate
    pip3 "$@"
    deactivate
}
EOF
)

# Check if the functions are already in .bashrc
if grep -q "run_python()" ~/.bashrc && grep -q "run_pip()" ~/.bashrc; then
    echo "Functions are already in .bashrc."
else
    # Append the functions to .bashrc
    echo "$functions_to_add" >> ~/.bashrc
fi

# Update .bashrc with new aliases and environment variables
echo "export MAKEFLAGS=\"-j\$(nproc)\"" >> ~/.bashrc
echo "alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y'" >> ~/.bashrc
echo "alias connect='nordvpn connect'" >> ~/.bashrc
echo "alias disconnect='nordvpn disconnect'" >> ~/.bashrc
echo "alias python='run_python'" >> ~/.bashrc
echo "alias pip='run_pip'" >> ~/.bashrc

# Prompt for reboot
read -p "Do you want to reboot the system now? [y/N] " choice
case "$choice" in
  y|Y ) sudo reboot;;
  * ) echo "Please reboot the system later to apply changes.";;
esac