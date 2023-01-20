#!/bin/bash
# A freshly-installed-from-ISO Fedora system is NOT ready to have the playbook run against it.
# This script will prepare it to have the local Ansible role played against it, after a default fresh installation!

set -e 

clear
echo "UNCOMMENT THE LINE ALLOWING 'wheel' group password-less access"
read -p "Hit enter when ready:"
sudo visudo

echo "Installing ansible"
sudo dnf install ansible -y

echo "Allowing SSH key access"
if ! [ -d ~/.ssh ]; then
	mkdir ~/.ssh --mode 0700
fi

echo "Setting up authorized_keys"
cp roles/desktop/files/authorized_keys ~/.ssh/ 
chmod 0600 ~/.ssh/authorized_keys

#echo "Installing ssh credentials"
#cp roles/desktop/files/id* ~/.ssh/
#chmod 0600 ~/.ssh/id*

echo "Accepting the ssh key from localhost" 
if ! [ -e ~/.ssh/known_hosts ]; then
	ssh-keyscan localhost 2> /dev/null > ~/.ssh/known_hosts
fi

echo "Enabling and starting sshd" 
sudo systemctl enable sshd
sudo systemctl start sshd


echo
echo
echo "--->  Reminder: use 'sudo visudo' to **remove** your password-less access to wheel, after running the playbook!  <----"
