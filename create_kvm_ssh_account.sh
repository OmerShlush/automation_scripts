#!/bin/bash
set -e

# Create user and set password
sudo adduser sshadmin
sudo usermod -aG libvirt,kvm sshadmin

