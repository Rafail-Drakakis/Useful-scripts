#!/bin/bash

# Function to configure Git user info
configure_git() {
    echo "Enter your name for Git (e.g., John Doe):"
    read git_name
    echo "Enter your email for Git (e.g., user@example.com):"
    read git_email

    # Configure Git with the provided name and email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"

    echo "Git configured with Name: $git_name and Email: $git_email"
}

# Function to add SSH key to GitLab
add_gitlab_ssh() {
    echo "Enter your GitLab email (e.g., user@example.com):"
    read gitlab_email
    ssh-keygen -t rsa -b 2048 -C "$gitlab_email" -f ~/.ssh/gitlab_rsa
    echo "SSH key generated for GitLab."
    cat ~/.ssh/gitlab_rsa.pub
    echo "Copy the above key and add it to your GitLab account under SSH keys."
}

# Function to add SSH key to GitHub
add_github_ssh() {
    echo "Enter your GitHub email (e.g., user@github.com):"
    read github_email
    echo "Enter a filename for your GitHub SSH key (e.g., github_rsa):"
    read github_keyname
    ssh-keygen -t rsa -C "$github_email" -f ~/.ssh/"$github_keyname"
    echo "SSH key generated for GitHub."
    cat ~/.ssh/"$github_keyname".pub
    echo "Copy the above key and add it to your GitHub account under SSH keys."
}

# Main menu for selecting the service
echo "Select the service to add SSH key:"
echo "1. GitLab"
echo "2. GitHub"
read service

# Configure Git user information
configure_git

# Run the appropriate SSH key generation based on user input
case $service in
    1) add_gitlab_ssh ;;
    2) add_github_ssh ;;
    *) echo "Invalid option selected. Exiting."; exit 1 ;;
esac