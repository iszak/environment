#!/usr/bin/env sh

apt-get autoremove --yes
apt-get autoclean --yes
apt-get clean --yes

# Clean logs
find /var/log -type f -iname "*log" -exec truncate --size 0 {} \;
