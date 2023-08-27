# Ubuntu logistics
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM show-apps-at-top true # Move taskbar to bottom
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true # Move the "show applications" button to the right

# sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null # Import Sublime Text GPG key
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list # Add Sublime Text repository to apt sources

# Install software
sudo add-apt-repository universe
sudo apt install gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer sublime-text shutter software-properties-common apt-transport-https filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg yt-dlp jupyter tesseract-ocr snapd gnome-sound-recorder -y
sudo snap install notepad-plus-plus code -y

# Install python libraries
pip install pyinstaller numpy pandas matplotlib requests beautifulsoup4 pygame pytube openpyxl pytesseract Pillow time random sys re docx urllib moviepy pdf2docx PyPDF2 pdf2image pathlib

# Install Google Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb #download the .deb file
sudo dpkg -i google-chrome-stable_current_amd64.deb #install google chrome
rm google-chrome-stable_current_amd64.deb #remove the file

wget https://sourceforge.net/projects/orthos-spell/files/v.0.4.0./orthos-el_GR-0.4.0-87.oxt # Download orthos.oxt, a Greek dictionary for Libre Office

# Set up aliases for frequently used commands
echo "alias python='python3'" >> ~/.bashrc # Enter python instead of python3
echo "alias pip='pip3'" >> ~/.bashrc # Enter pip instead of pip3
echo "MAKEFLAGS= \"-J$(nproc)\"" # This command configures the behavior of the make tool

# Final system update
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
sudo reboot # Reboot the system