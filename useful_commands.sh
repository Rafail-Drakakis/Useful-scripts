# Install Nordvpn on linux
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)		 # Install the app.
sudo usermod -aG nordvpn $USER                                           # Then, log out and back in.
nordvpn login									   						 # Log in to your account.
nordvpn connect 								 						 # Connect to a server.

# How to add a Gitlab account 
ssh-keygen -t rsa -b  2048 -C "<email>"   			 # Generate ssh key and ress enter in the next three options.
cat ~/.ssh/id_rsa.pub                                # Display the ssh key and copy the printed text. Then, add it to ssh keys in Gitlab.

# How to add a Github account
cd ~/.ssh                                            # Change directory to the .ssh folder in the user's home directory
ssh-keygen -t rsa -C "<email>" -f "<username>"       # Generate an SSH key pair using the RSA algorithm
cat <username>.pub #                                 # Display the public key content on the terminal


# Commands for tests
chmod u+x <file_name>               # Make the "<file_name>" file executable for the user
sh test.sh <executable_name> ./     # Execute the script with "<executable_name>" as an argument and the current directory
sh test.sh <executable_name> tests  # Execute the script with "<executable_name>" as an argument and the "tests" directory
