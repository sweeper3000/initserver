#!/bin/bash

# ask user what username they want
echo "What username do you want for the new user?"
read newuser

# create a new user called main, give it sudo access
adduser $newuser
usermod -aG sudo $newuser

# copy the root's .ssh folder to the main's home directory
cp -r /root/.ssh /home/$newuser

# cd to main's home folder
cd /home/$newuser

# change ownership of .ssh and contents to main
chown $newuser .ssh 
chown $newuser .ssh/authorized_keys

# set permissions
chmod 700 .ssh
chmod 644 .ssh/authorized_keys

# check for server updates and install them
apt update && apt upgrade

# ask to install software
echo "Do you want to install the software listed in this script now? y/n"
read install

if [ $install == "y" || $install == "Y" ]; then
	apt install fail2ban mosh
else
	echo "skipping..."
fi

# add rules to ufw and enable it
ufw allow 22
ufw allow 60000:60003/udp
ufw enable
