# == Class: hostname::params
#
# A class to set the default parameters of hostname
#
# === Examples
#
#  class { 'hostname::params': }
#
class hostname::params {
  $hostname_file = '/etc/hostname'
}
