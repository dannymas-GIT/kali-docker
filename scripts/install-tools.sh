#!/bin/bash

echo "Installing Kali Security Tools..."

# Update package lists
sudo apt-get update

# Install tools
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    kali-tools-top10 \
    metasploit-framework \
    wireshark \
    john \
    sqlmap \
    netcat-traditional \
    nmap \
    nikto

echo "Installation complete!"
echo "Press Enter to close this window"
read 