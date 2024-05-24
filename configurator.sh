#!/bin/bash
set -e  # Stop on error

# Configure GNOME Shell extensions
echo "Configuring GNOME Shell extensions..."
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true

# Add repositories and update
echo "Adding repositories and updating system..."
sudo add-apt-repository universe -y || true  # Continue even if repository addition fails
sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade

# Download and install packages
echo "Downloading and installing required packages..."
wget -O orthos-el_GR-0.4.0-87.oxt "https://downloads.sourceforge.net/project/orthos-spell/v.0.4.0./orthos-el_GR-0.4.0-87.oxt"
sudo apt install -y gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer shutter software-properties-common apt-transport-https libreoffice default-jdk filezilla copyq wget python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg jupyter-notebook tesseract-ocr snapd gnome-sound-recorder python3-venv

# Install VS Code and IntelliJ IDEA
echo "Installing Visual Studio Code and IntelliJ IDEA..."
sudo snap install code --classic
sudo snap install intellij-idea-community --classic --edge

# Install and configure Google Chrome
echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt install -f
rm google-chrome-stable_current_amd64.deb

# Create utility scripts for pip and Python
echo "Creating utility scripts for pip and Python..."
for tool_script in "pip:run_pip.sh" "python:run_python.sh"; do
    tool=$(echo "$tool_script" | cut -d: -f1)
    script_name=$(echo "$tool_script" | cut -d: -f2)
    script_path="$HOME/$script_name"
    
    # Clear existing script file and write new contents
    echo "source $VENV_PATH/bin/activate" > "$script_path"
    echo "${tool}3 \"\$@\"" >> "$script_path"
    echo "deactivate" >> "$script_path"
    
    chmod +x "$script_path"
    echo "Created $script_name in $HOME"
done

# Define the path to the virtual environment
VENV_PATH="$HOME/my_venv"

# Create or recreate virtual environment
echo "Creating or recreating virtual environment..."
python3 -m venv "$VENV_PATH"

# Activate the virtual environment
echo "Activating virtual environment..."
. "$VENV_PATH/bin/activate"

# Install Python libraries
echo "Installing Python libraries..."
pip install torch torchvision torchaudio ffprobe PyPDF2 SpeechRecognition urllib3 matplotlib beautifulsoup4 ffmpeg tk pygame phonenumbers python-docx openpyxl numpy customtkinter ctkmessagebox qrcode pandas requests Pillow pdf2image moviepy pyshorteners pdf2docx yt-dlp tabula-py pytesseract opencv-python folium rasterio punctuators

# Deactivate the virtual environment
echo "Deactivating virtual environment..."
deactivate

# Update .bashrc with new aliases and environment variables
echo "Setting aliases and environment variables..."
echo "export MAKEFLAGS=\"-j\$(nproc)\"" >> ~/.bashrc
echo "alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y'" >> ~/.bashrc
echo "alias connect='nordvpn connect'" >> ~/.bashrc
echo "alias disconnect='nordvpn disconnect'" >> ~/.bashrc
echo "alias pip='$HOME/run_pip.sh'" >> ~/.bashrc
echo "alias python='$HOME/run_python.sh'" >> ~/.bashrc

# Install and configure neovim
echo "Installing and configuring Neovim..."
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
nvim +qall  # Launches and closes Neovim to initialize configuration

# Prompt for reboot
read -p "Do you want to reboot the system now? [y/N] " choice
case "$choice" in
  y|Y ) sudo reboot;;
  * ) echo "Please reboot the system later to apply changes.";;
esac