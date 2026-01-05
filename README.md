# Useful Scripts

A collection of utility scripts for system configuration, Git setup, and Windows product key validation.

## Scripts

### 1. `account_setup.sh`

A Bash script to quickly configure Git and generate SSH keys for GitHub.

**Features:**
- Configures Git global user name and email
- Generates SSH keys for GitHub authentication
- Creates `~/.ssh` directory if it doesn't exist
- Prompts before overwriting existing keys
- Displays the public key for easy copying to GitHub

**Usage:**
```bash
chmod +x account_setup.sh
./account_setup.sh
```

The script will prompt you for:
- Git name
- Git email
- GitHub email
- SSH key filename (e.g., `github_rsa`)

### 2. `configurator.sh`

A comprehensive system configuration script for Linux (Debian/Ubuntu-based distributions).

**Features:**
- GNOME Shell extensions configuration
- System package installation (development tools, multimedia, office, LaTeX, etc.)
- Python virtual environment setup with common packages
- LaTeXMK configuration
- Bash aliases and functions
- Repository management
- Brave browser installation
- Orthos spell checker download

**Packages installed include:**
- **Essential**: git, vim, htop, tree, curl, wget, etc.
- **Development**: Python 3, pip, JDK, g++, cmake
- **Multimedia**: VLC, FFmpeg, Shutter
- **Office**: LibreOffice, FileZilla, qBittorrent
- **LaTeX**: Full TeX Live distribution with Greek language support
- **System**: GNOME Tweaks, GParted, SSH, etc.

**Python packages**: PyTorch, matplotlib, pandas, opencv-python, and many more

**Usage:**
```bash
chmod +x configurator.sh
./configurator.sh
```

**Note:** This script requires sudo privileges for package installation and modifies your system configuration. Review the script before running it.

### 3. `windows_product_key_validator.py`

A Python script to validate Windows product keys using the Windows Software Licensing Management Tool (`slmgr`).

**Features:**
- Reads product keys from a file
- Validates each key using Windows `slmgr /dli` command
- Separates valid and invalid keys into different output files

**Usage:**
```bash
python windows_product_key_validator.py
```

**Note:** 
- This script is designed to run on Windows (requires `slmgr.exe`)
- The script expects product keys in `C:\Users\Rafail\Downloads\keys.txt`
- Valid keys are saved to `valid.txt`
- Invalid keys are saved to `invalid.txt`
- Modify the file path in the script to match your setup

## Requirements

### For Bash scripts (`account_setup.sh`, `configurator.sh`):
- Linux-based operating system (Debian/Ubuntu recommended)
- Bash shell
- sudo privileges (for `configurator.sh`)
- Git installed (for `account_setup.sh`)

### For Python script (`windows_product_key_validator.py`):
- Python 3
- Windows operating system
- Administrator privileges (for `slmgr` command)

## License

This repository contains utility scripts for personal use. Use at your own discretion.

## Contributing

Feel free to submit issues or pull requests for improvements.

