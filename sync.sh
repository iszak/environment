#!/usr/bin/env sh

rm -rf ~/Dropbox/Environment/*

git ls-files | xargs -I file dirname file | sort | uniq | xargs -I dir mkdir -p ~/Dropbox/Environment/dir

git ls-files | xargs -I file cp file ~/Dropbox/Environment/file
