#!/bin/bash

# VARIABLES
defaultPackages="mosh slurm"

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
echo "Do you want to install the software listed in this script now?"
echo "Currently the packages that would be installed are $defaultPackages"

echo "(1) Install packages"
echo "(2) Add more packages to install"
echo "(3) Don't install anything"
read install

if [ $install == 1 ]; then
	apt install $defaultPackages
elif [ $install == 2 ]; then
    echo "Enter the package names, seperated by a space that you want to install"
    read userPackages

     echo "Now the packages that will be installed are $defaultPackages $userPackages"
    apt install $defaultPackages $userPackages
else
	echo "skipping..."
fi

sudo apt autoremove

# add rules to ufw and enable it
ufw allow 22
ufw allow 60000:60003/udp
ufw enable
