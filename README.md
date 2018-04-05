# initserver
A script that sets up a server to my personal liking.

**This script is meant to be run as root on a fresh, new server.**

# Tasks
- Create new user, give it sudo access
- Copy ```.ssh``` folder to new user's ```/home``` directory
- Set ownership to the new user
- Set permissions: 700 for ```.ssh```, 644 for ```.ssh/authorized_keys```
- Check for and install server updates
- Allow ports 22, 60000:60003 through ufw
- Enable ufw
- Install fail2ban and mosh

This script will be updated as needs evolve.
