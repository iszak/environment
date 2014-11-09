# == Class: npm
#
# A class to install npm
#
# === Parameters
#
# === Examples
#
#  class { 'npm': }
#
class npm () {
  package { 'npm':
    ensure => latest
  }
}
