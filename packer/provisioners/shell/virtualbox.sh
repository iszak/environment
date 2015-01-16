#!/usr/bin/env sh

# Build tools
apt-get install build-essential --yes

# Host kernels modules update
apt-get install dkms --yes

# Install the VirtualBox guest additions
mount -o loop VBoxGuestAdditions.iso /mnt

yes | sh /mnt/VBoxLinuxAdditions.run

umount /mnt

rm VBoxGuestAdditions.iso
