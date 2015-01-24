#!/usr/bin/env sh

# Box build time
date > /etc/vagrant_box_build_time

# Create vagrant user with password
if [ -z "$(getent passwd vagrant)" ]; then
    useradd --groups sudo --shell /bin/bash --create-home vagrant
fi

echo "vagrant:vagrant" | chpasswd


# Create ssh directory
mkdir -p /home/vagrant/.ssh

# Download public key
wget https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys

# Permissions / ownership
chmod 0600 /home/vagrant/.ssh/authorized_keys
chmod 0700 /home/vagrant/.ssh/
chown -R vagrant:vagrant /home/vagrant/.ssh

# NFS Client
apt-get -y install nfs-common

# Passwordless sudo
echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Faster SSH
echo "UseDNS no" >> /etc/ssh/sshd_config
