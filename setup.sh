#!/usr/bin/env bash

PACKER_VARIABLES="packer/variables/vagrant.json"
UBUNTU_PRESEED="packer/config/preseed.cfg"
VAGRANT_FILE="vagrant/Vagrantfile"
HIERA_USER="vagrant/provisioners/puppet/environments/development/hieradata/users/user.yaml"



echo "Enter a full name for the OS (Vagrant): "
read -r os_full_name

if [ -z "$os_full_name" ]; then
    os_full_name="Vagrant"
fi

echo "Enter a username for the OS (vagrant): "
read -r os_username

if [ -z "$os_username" ]; then
    os_username="vagrant"
fi

echo "Enter a hostname for the OS (vagrant): "
read -r os_hostname

if [ -z "$os_hostname" ]; then
    os_hostname="vagrant"
fi


echo "Enter a password for the OS (vagrant): "
read -r os_password

if [ -z "$os_password" ]; then
    os_password="vagrant"
fi


echo "Enter a email for Git: "
read -r git_email

if [ -z "$git_email" ]; then
    echo "You must provide a email for Git" 1>&2
    exit 1
fi

echo "Enter a full name for Git: "
read -r git_name

if [ -z "$git_name" ]; then
    echo "You must provide a name for Git" 1>&2
    exit 1
fi

echo "Enter a user name for Github: "
read -r git_user

if [ -z "$git_user" ]; then
    echo "You must provide a user name for Github" 1>&2
    exit 1
fi


# TODO: Use key over password
#ssh-keygen -f file.rsa -t rsa -N ''

# Copy templates
cp "$PACKER_VARIABLES.template" "$PACKER_VARIABLES"
cp "$UBUNTU_PRESEED.template" "$UBUNTU_PRESEED"
cp "$VAGRANT_FILE.template" "$VAGRANT_FILE"
cp "$HIERA_USER.template" "$HIERA_USER"

# TODO: Fix
postgres_user=$os_username
postgres_password=$(echo -n "$os_password$os_username" | md5)

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
sed -i '' "s/POSTGRESQL_PASSWORD/$postgres_password/g" "$HIERA_USER"
sed -i '' "s/POSTGRESQL_USER/$postgres_user/g" "$HIERA_USER"

sed -i '' "s/USERNAME/$os_username/g" "$HIERA_USER"
sed -i '' "s/PASSWORD/$os_password/g" "$HIERA_USER"
sed -i '' "s/GIT_NAME/$git_name/g" "$HIERA_USER"
sed -i '' "s/GIT_EMAIL/$git_email/g" "$HIERA_USER"
sed -i '' "s/GIT_USER/$git_user/g" "$HIERA_USER"
