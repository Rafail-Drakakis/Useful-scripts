# Ubuntu logistics
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM' # Move taskbar to bottom
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true  # Move the "show applications" button to the left

# Add the "universe" repository
sudo add-apt-repository universe -y

# Download orthos, a Greek dictionary for libreoffice
wget -O orthos-el_GR-0.4.0-87.oxt "https://downloads.sourceforge.net/project/orthos-spell/v.0.4.0./orthos-el_GR-0.4.0-87.oxt?ts=gAAAAABmL1_5wk2L8cl0R0BYsayKcpO8pLhEsem7pcm9uuuJ40-cYuiMDHbmVIqkIzB97OGtTjkXs-aIxzXpOCfeNyi-4r8L7g%3D%3D&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Forthos-spell%2Ffiles%2Flatest%2Fdownload"

# Install software
sudo apt install -y gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer shutter software-properties-common apt-transport-https libreoffice default-jdk filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg jupyter-notebook tesseract-ocr snapd gnome-sound-recorder

# Install VS Code and IntelliJ IDEA via snap
sudo snap install code --classic && sudo snap install intellij-idea-community --classic --edge

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt install -f
rm google-chrome-stable_current_amd64.deb

# Python libraries installation via pip
#!/bin/sh
. source ~/my_venv/bin/activate
pip3 install torch torchvision torchaudio ffprobe PyPDF2 SpeechRecognition urllib3 matplotlib beautifulsoup4 ffmpeg tk pygame phonenumbers python-docx openpyxl numpy customtkinter ctkmessagebox qrcode pandas requests Pillow pdf2image moviepy pyshorteners pdf2docx yt-dlp tabula-py pytesseract opencv-python folium rasterio punctuators
deactivate

# Set up aliases and environment variables
echo "export MAKEFLAGS=\"-j\$(nproc)\"" >> ~/.bashrc
echo "alias python='python3'" >> ~/.bashrc
echo "alias pip='pip3'" >> ~/.bashrc
echo "alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y'" >> ~/.bashrc
echo "alias activate='source ~/my_venv/bin/activate'" >>    
echo "alias connect='nordvpn connect'" >> ~/.bashrc
echo "alias disconnecte='nordvpn disconnect'" >> ~/.bashrc

# Install neovim
cd
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
ls ~/.config/nvim
nvim #Then, exit with ":q"

# Final system update and reboot
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y
sudo reboot