# Ubuntu logistics
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM' # Move taskbar to bottom
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true  # Move the "show applications" button to the left

# Install software
sudo add-apt-repository universe
sudo apt install gnome-shell-extension-prefs gnome-tweaks ttf-mscorefonts-installer shutter software-properties-common apt-transport-https filezilla copyq wget clang-format-11 python3 python3-pip qbittorrent g++ cmake vlc git tree htop nmap ssh screen unzip curl gparted vim ffmpeg jupyter tesseract-ocr snapd gnome-sound-recorder -y
sudo apt install default-jdk                                #install java
sudo snap install code --classic                            #install vs code
sudo snap install sublime-text --classic                    #install sublime-text
sudo snap install intellij-idea-community --classic --edge  #install intellij

# Install Google Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb   #download the .deb file
sudo dpkg -i google-chrome-stable_current_amd64.deb                              #install google chrome
rm google-chrome-stable_current_amd64.deb                                        #remove the file

# Download orthos.oxt, a Greek dictionary for Libre Office
wget https://sourceforge.net/projects/orthos-spell/files/v.0.4.0./orthos-el_GR-0.4.0-87.oxt 

# Set up aliases for frequently used commands
echo "alias python='python3'" >> ~/.bashrc # Enter python instead of python3
echo "alias pip='pip3'" >> ~/.bashrc # Enter pip instead of pip3
echo "MAKEFLAGS= \"-J$(nproc)\"" # This command configures the behavior of the make tool
echo "alias update='sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y'" >> ~/.bashrc

# Final system update
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
sudo reboot # Reboot the system