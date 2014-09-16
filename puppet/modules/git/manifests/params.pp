# == Class: git::params
#
# A class to configure git
#
# === Examples
#
#  class { 'git::params': }
#
class git::params {
  $bin_path = '/usr/bin/git'
}
