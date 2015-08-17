# Read Me

## Installation

- Clone this repository ```git clone --recursive git@github.com:iszak/environment.git```

### Vagrant

- Install latest [Vagrant](https://www.vagrantup.com/)

### VirtualBox

- Install latest [VirtualBox](https://www.virtualbox.org/)

### Packer

- Install latest [Packer](https://packer.io/)

### SSHFS
- Install [vagrant-sshfs](https://github.com/fabiokr/vagrant-sshfs) plugin ```vagrant plugin install vagrant-sshfs```
- Install [OSX Fuse](https://github.com/osxfuse/osxfuse/releases) and [SSHFS](https://github.com/osxfuse/sshfs/releases)


## Configuration

Run ```./setup.sh```

## Packer

Build the base vagrant box

```
cd packer/
packer build -var-file=variables/vagrant.json vagrant.json
```


## Puppet / Hiera

Edit vagrant/provisioners/puppet/environments/development/hiera.yaml and add projects you want, example below

```
---
:backends: yaml

:yaml:
  :datadir: /vagrant/provisioners/puppet/hiera/

:hierarchy:
    - private

    - environments/development
    - environments/shared

    - projects/development/crowdwish-client
    - projects/shared/crowdwish-client

    - users/user
    - users/vagrant

    - roles/postgresql
    - roles/node
    - roles/ruby
    - roles/php
    - roles/web
    - roles/base
    - common

:logger: console

:merge_behavior: deeper
```


Create **vagrant/provisioners/puppet/environments/development/hieradata/private.yaml** example below

```
---
file:
    vagrant_ssh_default:
        content: "PRIVATE KEY"

project::static:
    crowdwish_client:
        ssh_key: "PRIVATE KEY"
```

Change the personal key with the key you will be pushing/pulling with and the they key for the project, this may be the same key. Replace all the new lines with "\n" string literal, you can copy it with the command below

```
cat ~/.ssh/id_rsa | perl -p -e 's/\n/\\n/' | pbcopy
```

## Vagrant
```
cd vagrant/
vagrant up
```
