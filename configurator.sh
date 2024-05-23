# Configure GNOME Shell extensions
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true

# Add repositories and update
sudo add-apt-repository universe -y
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y

# Download and install packages
wget -O orthos-el_GR-0.4.0-87.oxt "https://downloads.sourceforge.net/project/orthos-spell/v.0.4.0./orthos-el_GR-0.4.0-87.oxt?ts=gAAAAABmL1_5wk2L8cl0R0BYsayKcpO8pLhEsem7pcm9uuuJ40-cYuiMDHbmVIqkIzB97OGtTjkXs-aIxzXpOCfeNyi-4r8L7g%3D%3D&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Forthos-spell%2Ffiles%2Flatest%2Fdownload"
sudo apt install -y gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer shutter software-properties-common apt-transport-https libreoffice default-jdk filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg jupyter-notebook tesseract-ocr snapd gnome-sound-recorder

# Install VS Code and IntelliJ IDEA
sudo snap install code --classic
sudo snap install intellij-idea-community --classic --edge

# Install and configure Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt install -f
rm google-chrome-stable_current_amd64.deb

# Activate Python virtual environment and install libraries
source ~/my_venv/bin/activate
pip3 install torch torchvision torchaudio ffprobe PyPDF2 SpeechRecognition urllib3 matplotlib beautifulsoup4 ffmpeg tk pygame phonenumbers python-docx openpyxl numpy customtkinter ctkmessagebox qrcode pandas requests Pillow pdf2image moviepy pyshorteners pdf2docx yt-dlp tabula-py pytesseract opencv-python folium rasterio punctuators
deactivate

HOME_PATH="$HOME"
for tool_script in "pip:run_pip.sh" "python:run_python.sh"; do
    tool=$(echo "$tool_script" | cut -d: -f1)
    script_name=$(echo "$tool_script" | cut -d: -f2)
    script_path="$HOME_PATH/$script_name"
    
    echo "source /home/rafail/my_venv/bin/activate" >> "$script_path"
    echo "${tool}3 \"\$@\"" >> "$script_path"
    echo "deactivate" >> "$script_path"
    
    chmod +x "$script_path"
done

# Set aliases and environment variables
echo "export MAKEFLAGS=\"-j\$(nproc)\"" >> ~/.bashrc
echo "alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y'" >> ~/.bashrc
echo "alias connect='nordvpn connect'" >> ~/.bashrc
echo "alias disconnect='nordvpn disconnect'" >> ~/.bashrc
echo "alias pip='/home/rafail/run_pip.sh'" >> ~/.bashrc
echo "alias python='/home/rafail/run_python.sh'" >> ~/.bashrc

# Install and configure neovim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
nvim #Then, exit with ":q"

# Reboot the system to apply all changes
sudo reboot