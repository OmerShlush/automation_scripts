#!/bin/bash
set -e

USERNAME="sshadmin"
PASSWORD="Aa123456!" 

# Create user and set password
sudo useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | sudo chpasswd

# Add to required groups
sudo usermod -aG libvirt,kvm "$USERNAME"