# == Class: zsh
#
# A class to install zsh
#
# === Examples
#
#  class { "zsh": }
#
class zsh () {
  package { 'zsh':
    ensure => latest
  }
}
