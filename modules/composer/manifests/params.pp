# == Class: composer::params
#
# A class to set the default parameters of composer
#
# === Examples
#
#  class { 'composer::params': }
#
class composer::params {
  $bin_path        = '/usr/bin/composer'

  $install_user    = 'root'
  $install_group   = 'root'
  $install_timeout = 300
}
