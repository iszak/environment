# Read Me

## Installation

### Vagrant

- Install latest [Vagrant](https://www.vagrantup.com/)
- Install [vagrant-sshfs](https://github.com/fabiokr/vagrant-sshfs) plugin ```vagrant plugin install vagrant-sshfs```

### VirtualBox

- Install latest [VirtualBox](https://www.virtualbox.org/)


## Configuration

Run ```./setup.sh```

## Packer

Build the base vagrant box

```
cd packer/
packer build template.json
cd vagrant/
vagrant up
```


## Vagrant

Edit vagrant/puppet/hiera.yaml and add projects you want, example below

```
---
:backends: yaml

:yaml:
  :datadir: /vagrant/vagrant/puppet/hiera/

:hierarchy:
    - environments/development
    - environments/shared

    - projects/development/crowdwish
    - projects/shared/crowdwish

    - roles/database
    - roles/node
    - roles/ruby
    - roles/php
    - roles/web
    - roles/base
    - common

:logger: console

:merge_behavior: deeper
```


Create **vagrant/puppet/hiera/private.yaml** example below

```
---
file:
    vagrant_ssh_default:
        content: "PERSONAL KEY"

project::static:
    crowdwish_client:
        ssh_private_key: "PRIVATE KEY"
        ssh_public_key: "PUBLIC KEY"
```

Change the personal key with the key you will be pushing/pulling with and the they key for the project, this may be the same key. Replace all the new lines with "\n" string literal, you can copy it with the command below

```
cat ~/.ssh/id_rsa | perl -p -e 's/\n/\\n/' | pbcopy
```
