#!/usr/bin/env sh

echo "Etc/GMT" > /etc/timezone

dpkg-reconfigure tzdata --frontend noninteractive
