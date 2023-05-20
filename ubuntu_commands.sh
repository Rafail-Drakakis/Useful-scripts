#Ubuntu logistics
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM # Move taskbar to bottom
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true #Move the "show applications key to the right"
sudo apt install gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer -y # Install gnome-tweaks and microsoft fonts

#Install sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Install Google Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb #download the .deb file
sudo dpkg -i google-chrome-stable_current_amd64.deb #install google chrome
rm google-chrome-stable_current_amd64.deb #remove the file

# Install software
sudo apt install software-properties-common apt-transport-https filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg yt-dlp jupyter tesseract-ocr snapd -y
sudo snap install notepad-plus-plus code -y

#Install python libraries
pip install numpy pandas matplotlib requests beautifulsoup4 pygame pytube openpyxl pytesseract Pillow pydub shutil itertools time random sys re docx urllib moviepy pdf2docx PyPDF2 pdf2image pathlib

# Set up aliases for frequently used commands
echo "alias jupyter='jupyter notebook'" >> ~/.bashrc # Enter jupyter instead of jupyter notebook
echo "alias google='google-chrome'" >> ~/.bashrc # Enter google instead of google-chrome
echo "alias python='python3'" >> ~/.bashrc # Enter python instead of python3
echo "alias pip='pip3'" >> ~/.bashrc # Enter pip instead of pip3
echo "MAKEFLAGS= \"-J$(nproc)\"" # This command sets the number of jobs make can run simultaneously

# Final system update
sudo apt-get update -y # Update the system
sudo apt-get upgrade -y # Upgrade the system
sudo apt-get dist-upgrade -y # Upgrade the distribution
sudo reboot # Reboot the system
