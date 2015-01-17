#!/usr/bin/env sh

PACKER_VARIABLES="packer/variables.json"
UBUNTU_PRESEED="packer/config/preseed.cfg"
VAGRANT_FILE="vagrant/Vagrantfile"
HIERA_USER="vagrant/provisioners/puppet/hiera/users/user.yaml"

echo "Enter a full name: "
read full_name

if [ -z "$full_name" ]; then
    full_name="Vagrant"
fi

echo "Enter a username: "
read username

if [ -z "$username" ]; then
    username="vagrant"
fi

echo "Enter a email: "
read email

if [ -z "$email" ]; then
    email="email@address.com"
fi

echo "Enter a password: "
read password

if [ -z "$password" ]; then
    password="vagrant"
fi

echo "Enter a hostname: "
read hostname

if [ -z "$hostname" ]; then
    hostname="vagrant"
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
password_hash=$(echo -n "$password$username" | md5)

# Ubuntu
sed -i '' "s/FULLNAME/$full_name/g" "$UBUNTU_PRESEED"
sed -i '' "s/USERNAME/$username/g" "$UBUNTU_PRESEED"
sed -i '' "s/PASSWORD/$password/g" "$UBUNTU_PRESEED"

# Packer
sed -i '' "s/USERNAME/$username/g" "$PACKER_VARIABLES"
sed -i '' "s/PASSWORD/$password/g" "$PACKER_VARIABLES"
sed -i '' "s/HOSTNAME/$hostname/g" "$PACKER_VARIABLES"

# Vagrant
sed -i '' "s/USERNAME/$username/g" "$VAGRANT_FILE"
sed -i '' "s/PASSWORD/$password/g" "$VAGRANT_FILE"
sed -i '' "s/HOSTNAME/$hostname/g" "$VAGRANT_FILE"


# Hiera
sed -i '' "s/USERNAME/$username/g" "$HIERA_USER"
sed -i '' "s/FULLNAME/$full_name/g" "$HIERA_USER"
sed -i '' "s/EMAIL/$email/g" "$HIERA_USER"
sed -i '' "s/PASSWORD_HASH/$password_hash/g" "$HIERA_USER"
