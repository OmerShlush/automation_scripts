#!/bin/bash

set -e

apt update && sudo apt upgrade -y

apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst cloud-image-utils


usermod -aG libvirt "$(whoami)"
usermod -aG kvm "$(whoami)"


systemctl enable libvirtd
systemctl start libvirtd


if ! grep -q "br0" /etc/netplan/*.yaml; then
  bash -c 'cat > /etc/netplan/99-kvm-bridge.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    eno1:
      dhcp4: no
  bridges:
    br0:
      interfaces: [eno1]
      addresses: [192.168.122.100/24]
      gateway4: 192.168.122.1
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
EOF'
else
  echo "Bridge already configured."
fi

echo "KVM installation and setup complete!"
