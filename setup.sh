#!/usr/bin/env sh

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
cp packer/variables.json.template packer/variables.json
cp packer/config/preseed.cfg.template packer/config/preseed.cfg

cp vagrant/Vagrantfile.template vagrant/Vagrantfile

sed -i '' "s/FULLNAME/iszak/g" packer/config/preseed.cfg
sed -i '' "s/USERNAME/$username/g" packer/config/preseed.cfg
sed -i '' "s/PASSWORD/$password/g" packer/config/preseed.cfg

sed -i '' "s/USERNAME/$username/g" packer/variables.json
sed -i '' "s/PASSWORD/$password/g" packer/variables.json
sed -i '' "s/HOSTNAME/$hostname/g" packer/variables.json

sed -i '' "s/USERNAME/$username/g" vagrant/Vagrantfile
sed -i '' "s/PASSWORD/$password/g" vagrant/Vagrantfile
sed -i '' "s/HOSTNAME/$hostname/g" vagrant/Vagrantfile

