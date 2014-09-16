# == Class: git
#
# A class to install git
#
# === Examples
#
#  class { 'git': }
#
class git {
  include git::params

  package { 'git':
    ensure => latest
  }
}
