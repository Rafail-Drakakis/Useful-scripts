# Ubuntu logistics
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM' # Move taskbar to bottom
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true  # Move the "show applications" button to the left

# Add the "universe" repository
sudo add-apt-repository universe -y

# Install software
sudo apt update && sudo apt install -y gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer shutter software-properties-common apt-transport-https filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg jupyter-notebook tesseract-ocr snapd gnome-sound-recorder

# Install JDK
sudo apt install -y default-jdk

# Install VS Code and IntelliJ IDEA via snap
sudo snap install code --classic
sudo snap install intellij-idea-community --classic --edge

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt install -f
rm google-chrome-stable_current_amd64.deb

# Python libraries installation via pip
source ~/my_venv/bin/activate
pip3 install ffprobe PyPDF2 SpeechRecognition urllib3 matplotlib beautifulsoup4 ffmpeg tk pygame phonenumbers python-docx openpyxl numpy customtkinter ctkmessagebox qrcode pandas requests Pillow pdf2image moviepy pyshorteners pdf2docx yt-dlp tabula-py pytesseract opencv-python folium rasterio
deactivate

# Install neovim
cd
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
ls ~/.config/nvim
nvim #Then, exit with ":q"

# Set up aliases and environment variables
echo "alias python='python3'" >> ~/.bashrc
echo "alias pip='pip3'" >> ~/.bashrc
echo "export MAKEFLAGS=\"-j\$(nproc)\"" >> ~/.bashrc
echo "alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y'" >> ~/.bashrc
echo "alias activate='source ~/my_venv/bin/activate'" >> ~/.bashrc
echo "alias connect='nordvpn connect'" >> ~/.bashrc
echo "alias disconnecte='nordvpn disconnect'" >> ~/.bashrc

# Final system update and reboot
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y
sudo reboot