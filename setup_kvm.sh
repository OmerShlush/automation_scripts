#!/bin/bash

set -e

# Update system
apt update && apt upgrade -y

# Install KVM and supporting packages
apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst cloud-image-utils

# Add current user to groups
usermod -aG libvirt "$(whoami)"
usermod -aG kvm "$(whoami)"

# Enable and start libvirtd
systemctl enable libvirtd
systemctl start libvirtd

# Ensure default libvirt NAT network is active
virsh net-autostart default || true
virsh net-start default || true

echo "KVM installation complete. Using default NAT networking. No interface changes made."
