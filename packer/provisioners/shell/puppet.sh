#!/usr/bin/env sh

wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb

apt-get update
apt-get install puppet hiera facter --yes

gem install deep_merge --version=1.0.1

rm puppetlabs-release-trusty.deb

