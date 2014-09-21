# == Class: apache
#
# A class to install apache
#
# === Parameters
#
#
# === Examples
#
#  class { 'apache': }
#
class apache () {
  include apache::params

  package { 'apache2':
    ensure => latest
  }
}