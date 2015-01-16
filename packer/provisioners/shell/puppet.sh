#!/usr/bin/env sh

# apt-get install ruby-dev --yes

# gem install puppet --version=3.7.3
# gem install hiera --version=1.3.4
# gem install facter --version=2.3.0
# gem install deep_merge --version=1.0.1
# gem install bundler --version=1.7.10

wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb

apt-get update
apt-get install puppet hiera facter --yes

gem install deep_merge --version=1.0.1

rm puppetlabs-release-trusty.deb

