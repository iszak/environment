# == Class: ufw::params
#
# A class to set the default parameters of ufw
#
# === Examples
#
#  class { 'ufw::params': }
#
class ufw::params {
  $enable       = true
  $logging      = false
  $bin_path     = '/usr/sbin/ufw'
  $package_name = 'ufw'
}
