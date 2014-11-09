# == Class: npm::params
#
# A class to set the default parameters of npm
#
# === Examples
#
#  class { 'npm::params': }
#
class npm::params {
  $bin_path = '/usr/bin/npm'

  $install_user  = 'root'
  $install_group = 'root'
}
