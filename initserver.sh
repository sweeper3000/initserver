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
chown main .ssh 
chown main .ssh/authorized_keys

# set permissions
chmod 700 .ssh
chmod 644 .ssh/authorized_keys

# check for server updates and install them
apt update && apt upgrade

# install software
apt install fail2ban mosh

# add rules to ufw and enable it
ufw allow 22
ufw allow 60000:60003
ufw enable
