#!/usr/bin/env sh

PACKER_VARIABLES="packer/variables.json"
UBUNTU_PRESEED="packer/config/preseed.cfg"
VAGRANT_FILE="vagrant/Vagrantfile"
HIERA_USER="vagrant/provisioners/puppet/hiera/users/user.yaml"



echo "Enter a full name for the OS (Vagrant): "
read os_full_name

if [ -z "$os_full_name" ]; then
    os_full_name="Vagrant"
fi

echo "Enter a username for the OS (vagrant): "
read os_username

if [ -z "$os_username" ]; then
    os_username="vagrant"
fi

echo "Enter a hostname for the OS (vagrant): "
read os_hostname

if [ -z "$os_hostname" ]; then
    os_hostname="vagrant"
fi


echo "Enter a password for the OS (vagrant): "
read os_password

if [ -z "$os_password" ]; then
    os_password="vagrant"
fi


echo "Enter a email for Git (email@address.com): "
read git_email

if [ -z "$git_email" ]; then
    git_email="email@address.com"
fi

echo "Enter a full name for Git (Vagrant): "
read git_full_name

if [ -z "$git_full_name" ]; then
    git_full_name="Vagrant"
fi


# TODO: Use key over password
#ssh-keygen -f file.rsa -t rsa -N ''

# Copy templates
# if [ ! -f "$PACKER_VARIABLES" ]; then
    cp "$PACKER_VARIABLES.template" "$PACKER_VARIABLES"
# fi

# if [ ! -f "$UBUNTU_PRESEED" ]; then
    cp "$UBUNTU_PRESEED.template" "$UBUNTU_PRESEED"
# fi

# if [ ! -f "$VAGRANT_FILE" ]; then
    cp "$VAGRANT_FILE.template" "$VAGRANT_FILE"
# fi

# if [ ! -f "$HIERA_USER" ]; then
    cp "$HIERA_USER.template" "$HIERA_USER"
# fi

# TODO: Fix
password_hash=$(echo -n "$os_password$os_username" | md5)

# Ubuntu
sed -i '' "s/FULLNAME/$os_full_name/g" "$UBUNTU_PRESEED"
sed -i '' "s/USERNAME/$os_username/g" "$UBUNTU_PRESEED"
sed -i '' "s/PASSWORD/$os_password/g" "$UBUNTU_PRESEED"

# Packer
sed -i '' "s/USERNAME/$os_username/g" "$PACKER_VARIABLES"
sed -i '' "s/PASSWORD/$os_password/g" "$PACKER_VARIABLES"
sed -i '' "s/HOSTNAME/$os_hostname/g" "$PACKER_VARIABLES"

# Vagrant
sed -i '' "s/USERNAME/$os_username/g" "$VAGRANT_FILE"
sed -i '' "s/PASSWORD/$os_password/g" "$VAGRANT_FILE"
sed -i '' "s/HOSTNAME/$os_hostname/g" "$VAGRANT_FILE"


# Hiera
sed -i '' "s/USERNAME/$os_username/g" "$HIERA_USER"
sed -i '' "s/FULLNAME/$git_full_name/g" "$HIERA_USER"
sed -i '' "s/EMAIL/$git_email/g" "$HIERA_USER"
sed -i '' "s/PASSWORD_HASH/$password_hash/g" "$HIERA_USER"
