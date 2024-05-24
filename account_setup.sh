#!/bin/bash

# Function to add SSH key to GitLab
add_gitlab_ssh() {
    echo "Enter your GitLab email:"
    read gitlab_email
    ssh-keygen -t rsa -b 2048 -C "$gitlab_email" -f ~/.ssh/gitlab_rsa
    echo "SSH key generated for GitLab."
    cat ~/.ssh/gitlab_rsa.pub
    echo "Copy the above key and add it to your GitLab account under SSH keys."
}

# Function to add SSH key to GitHub
add_github_ssh() {
    echo "Enter your GitHub email:"
    read github_email
    echo "Enter a filename for your GitHub SSH key:"
    read github_keyname
    ssh-keygen -t rsa -C "$github_email" -f "~/.ssh/$github_keyname"
    echo "SSH key generated for GitHub."
    cat ~/.ssh/$github_keyname.pub
    echo "Copy the above key and add it to your GitHub account under SSH keys."
}

# Main menu for selecting the service
echo "Select the service to add SSH key:"
echo "1. GitLab"
echo "2. GitHub"
read service

case $service in
    1) add_gitlab_ssh ;;
    2) add_github_ssh ;;
    *) echo "Invalid option selected. Exiting."; exit 1 ;;
esac