#!/bin/bash

################################################################################
# System Configuration Script
# 
# This script configures a Linux system with:
# - GNOME Shell extensions settings
# - System packages and repositories
# - Python virtual environment with libraries
# - LaTeX configuration
# - Bash aliases and functions
################################################################################

set -euo pipefail  # Stop on error, undefined vars, and pipe failures

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Configuration
readonly VENV_PATH="${VENV_PATH:-$HOME/my_venv}"
readonly LATEXMKRC="$HOME/.latexmkrc"
readonly BASHRC="$HOME/.bashrc"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if running as root (should not be)
check_not_root() {
    if [ "$EUID" -eq 0 ]; then
        log_error "This script should not be run as root. Please run as a regular user."
        exit 1
    fi
}

# Configure GNOME Shell extensions
configure_gnome() {
    log_info "Configuring GNOME Shell extensions..."
    
    if ! command_exists gsettings; then
        log_warning "gsettings not found. Skipping GNOME configuration."
        return 0
    fi
    
    if gsettings list-schemas | grep -q "org.gnome.shell.extensions.dash-to-dock"; then
        gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM' || true
        gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true || true
        log_success "GNOME Shell extensions configured."
    else
        log_warning "Dash-to-dock extension not found. Install it first."
    fi
}

# Add repositories
add_repositories() {
    log_info "Adding repositories..."
    
    if ! command_exists add-apt-repository; then
        log_warning "add-apt-repository not found. Installing software-properties-common..."
        sudo apt-get install -y software-properties-common || true
    fi
    
    sudo add-apt-repository universe -y || log_warning "Failed to add universe repository (may already exist)"
    log_success "Repositories configured."
}

# Install Brave browser
install_brave() {
    log_info "Installing Brave browser..."
    
    if command_exists brave-browser; then
        log_warning "Brave browser is already installed. Skipping."
        return 0
    fi
    
    if curl -fsS https://dl.brave.com/install.sh | sudo bash; then
        log_success "Brave browser installed."
    else
        log_error "Failed to install Brave browser."
        return 1
    fi
}

# Download Orthos spell checker
download_orthos() {
    log_info "Downloading Orthos spell checker..."
    
    local orthos_file="orthos-el_GR-0.4.0-87.oxt"
    local orthos_url="https://downloads.sourceforge.net/project/orthos-spell/v.0.4.0./${orthos_file}"
    
    if [ -f "$orthos_file" ]; then
        log_warning "Orthos file already exists. Skipping download."
        return 0
    fi
    
    if wget -O "$orthos_file" "$orthos_url" 2>/dev/null; then
        log_success "Orthos spell checker downloaded to: $orthos_file"
    else
        log_warning "Failed to download Orthos spell checker. Continuing..."
    fi
}

# Install system packages
install_packages() {
    log_info "Installing system packages..."
    
    # Update package list first
    sudo apt-get update
    
    # Group packages logically
    local packages_essential=(
        "software-properties-common"
        "apt-transport-https"
        "curl"
        "wget"
        "git"
        "vim"
        "htop"
        "tree"
        "unzip"
    )
    
    local packages_development=(
        "python3"
        "python3-pip"
        "python3-venv"
        "python3-pygments"
        "g++"
        "cmake"
        "default-jdk"
    )
    
    local packages_multimedia=(
        "vlc"
        "ffmpeg"
        "gnome-sound-recorder"
        "shutter"
    )
    
    local packages_office=(
        "libreoffice"
        "filezilla"
        "qbittorrent"
    )
    
    local packages_system=(
        "gnome-shell-extension-prefs"
        "gnome-tweaks"
        "ttf-mscorefonts-installer"
        "gparted"
        "nmap"
        "ssh"
        "screen"
        "snapd"
    )
    
    local packages_latex=(
        "texlive-full"
        "texmaker"
        "texlive-latex-base"
        "texlive-latex-extra"
        "texlive-xetex"
        "texlive-fonts-recommended"
        "texlive-fonts-extra"
        "texlive-lang-greek"
        "texlive-science"
        "texlive-pictures"
        "texlive-lang-european"
        "lmodern"
        "fonts-linuxlibertine"
    )
    
    local packages_other=(
        "jupyter-notebook"
        "tesseract-ocr"
    )
    
    # Install all package groups
    local all_packages=(
        "${packages_essential[@]}"
        "${packages_development[@]}"
        "${packages_multimedia[@]}"
        "${packages_office[@]}"
        "${packages_system[@]}"
        "${packages_latex[@]}"
        "${packages_other[@]}"
    )
    
    if sudo apt-get install -y "${all_packages[@]}"; then
        log_success "System packages installed."
    else
        log_error "Some packages failed to install."
        return 1
    fi
}

# Configure LaTeXMK
configure_latexmk() {
    log_info "Configuring LaTeXMK..."
    
    # Backup existing config
    if [ -f "$LATEXMKRC" ]; then
        local backup_file="${LATEXMKRC}.bak.$(date +%Y%m%d%H%M%S)"
        cp -n "$LATEXMKRC" "$backup_file" && log_info "Backed up existing .latexmkrc to $backup_file"
    fi
    
    # Create new config
    cat > "$LATEXMKRC" <<'EOF'
# Clean minted cache dirs in the project root
$clean_ext      .= " _minted-%R/* _minted-%R _minted/* _minted";
$clean_full_ext .= " _minted-%R/* _minted-%R _minted/* _minted";

# If you ever use -outdir=build (or similar), also clean minted inside it:
if (defined $out_dir && length $out_dir) {
  $clean_ext      .= " $out_dir/_minted-%R/* $out_dir/_minted-%R $out_dir/_minted/* $out_dir/_minted";
  $clean_full_ext .= " $out_dir/_minted-%R/* $out_dir/_minted-%R $out_dir/_minted/* $out_dir/_minted";
}
EOF
    
    log_success "LaTeXMK configured at $LATEXMKRC"
}

# Setup Python virtual environment
setup_python_venv() {
    log_info "Setting up Python virtual environment at $VENV_PATH..."
    
    # Check if Python 3 is available
    if ! command_exists python3; then
        log_error "Python 3 is not installed. Please install it first."
        return 1
    fi
    
    # Create or recreate virtual environment
    if [ -d "$VENV_PATH" ]; then
        log_warning "Virtual environment already exists at $VENV_PATH"
        read -p "Do you want to recreate it? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$VENV_PATH"
            python3 -m venv "$VENV_PATH"
            log_success "Virtual environment recreated."
        else
            log_info "Using existing virtual environment."
        fi
    else
        python3 -m venv "$VENV_PATH"
        log_success "Virtual environment created."
    fi
    
    # Activate and install packages
    log_info "Installing Python packages..."
    source "$VENV_PATH/bin/activate"
    
    # Upgrade pip first
    pip install --upgrade pip --quiet
    
    # Install packages in groups for better error handling
    local pip_packages=(
        "torch" "torchvision" "torchaudio"
        "ffprobe" "PyPDF2" "SpeechRecognition" "urllib3"
        "matplotlib" "beautifulsoup4" "ffmpeg" "tk" "pygame" "python-docx"
        "openpyxl" "numpy" "customtkinter" "ctkmessagebox" "qrcode" "pandas"
        "requests" "Pillow" "pdf2image" "moviepy" "pyshorteners" "pdf2docx"
        "yt-dlp" "tabula-py" "pytesseract" "opencv-python" "folium"
        "rasterio" "punctuators"
    )
    
    if pip install --quiet "${pip_packages[@]}"; then
        log_success "Python packages installed."
    else
        log_warning "Some Python packages may have failed to install."
    fi
    
    deactivate
}

# Add content to .bashrc if it doesn't exist
add_to_bashrc() {
    local marker="$1"
    local content="$2"
    
    if ! grep -qF "$marker" "$BASHRC" 2>/dev/null; then
        echo "" >> "$BASHRC"
        echo "# Added by configurator.sh - $marker" >> "$BASHRC"
        echo "$content" >> "$BASHRC"
        return 0
    else
        return 1
    fi
}

# Configure bash aliases and functions
configure_bash() {
    log_info "Configuring bash aliases and functions..."
    
    # Create functions with dynamic path
    local functions_content=$(cat <<EOF
# Functions for Python virtual environment
run_python() {
    source "$VENV_PATH/bin/activate"
    python3 "\$@"
    deactivate
}

run_pip() {
    source "$VENV_PATH/bin/activate"
    pip3 "\$@"
    deactivate
}

# LaTeX compilation function
my_latex() {
    local file=\$1
    if [ -z "\$file" ]; then
        echo "Usage: my_latex <file.tex>"
        return 1
    fi
    latexmk -shell-escape "\$file" && latexmk -c
}
EOF
)
    
    # Add functions if not present
    if add_to_bashrc "run_python()" "$functions_content"; then
        log_success "Bash functions added."
    else
        log_info "Bash functions already exist in .bashrc."
    fi
    
    # Add aliases
    local aliases=(
        "export MAKEFLAGS=\"-j\$(nproc)\""
        "alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y'"
        "alias connect='nordvpn connect'"
        "alias disconnect='nordvpn disconnect'"
        "alias python='run_python'"
        "alias pip='run_pip'"
        "alias latex='my_latex'"
    )
    
    local added_count=0
    for alias_line in "${aliases[@]}"; do
        local marker=$(echo "$alias_line" | cut -d'=' -f1 | tr -d ' ')
        if add_to_bashrc "$marker" "$alias_line"; then
            ((added_count++))
        fi
    done
    
    if [ $added_count -gt 0 ]; then
        log_success "Added $added_count new entries to .bashrc"
    else
        log_info ".bashrc already contains all aliases and exports."
    fi
}

# Update system packages
update_system() {
    log_info "Updating system packages..."
    
    if sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get full-upgrade -y; then
        log_success "System updated."
    else
        log_warning "Some updates may have failed."
    fi
}

# Main execution
main() {
    log_info "Starting system configuration..."
    log_info "Virtual environment will be created at: $VENV_PATH"
    echo
    
    check_not_root
    
    # Ask for confirmation
    read -p "This script will install packages and modify your system. Continue? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Aborted by user."
        exit 0
    fi
    
    # Execute configuration steps
    configure_gnome
    add_repositories
    install_brave || true  # Non-critical
    download_orthos || true  # Non-critical
    install_packages
    configure_latexmk
    setup_python_venv
    configure_bash
    update_system
    
    log_success "Configuration completed!"
    echo
    log_info "Note: You may need to restart your terminal or run 'source ~/.bashrc' to use the new aliases and functions."
    
    # Prompt for reboot
    echo
    read -p "Do you want to reboot the system now? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_info "Rebooting system..."
        sudo reboot
    else
        log_info "Please reboot the system later to apply all changes."
    fi
}

# Run main function
main "$@"