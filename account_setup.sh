#!/bin/bash
echo "Enter your name for Git (e.g., John Doe):"
read -r git_name
echo "Enter your email for Git (e.g., user@example.com):"
read -r git_email

# Configure Git with the provided name and email
if ! git config --global user.name "$git_name"; then
    echo "Error: Failed to configure Git user name" >&2
    exit 1
fi

if ! git config --global user.email "$git_email"; then
    echo "Error: Failed to configure Git user email" >&2
    exit 1
fi

echo "Git configured with Name: $git_name and Email: $git_email"

echo "Enter your GitHub email (e.g., user@github.com):"
read -r github_email
echo "Enter a filename for your GitHub SSH key (e.g., github_rsa):"
read -r github_keyname

# Create ~/.ssh directory if it doesn't exist
if [ ! -d ~/.ssh ]; then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
fi

# Check if key already exists
if [ -f ~/.ssh/"$github_keyname" ]; then
    echo "Warning: SSH key ~/.ssh/$github_keyname already exists."
    echo "Do you want to overwrite it? (y/N):"
    read -r overwrite
    if [ "$overwrite" != "y" ] && [ "$overwrite" != "Y" ]; then
        echo "Skipping SSH key generation."
        exit 0
    fi
fi

# Generate SSH key non-interactively with no passphrase
if ! ssh-keygen -t rsa -b 4096 -C "$github_email" -f ~/.ssh/"$github_keyname" -N "" -q; then
    echo "Error: Failed to generate SSH key" >&2
    exit 1
fi

echo "SSH key generated for GitHub."
cat ~/.ssh/"$github_keyname".pub
echo ""
echo "Copy the above key and add it to your GitHub account under SSH keys."
