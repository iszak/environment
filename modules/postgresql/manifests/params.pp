# == Class: postgresql::params
#
# A class to set the default parameters of postgresql
#
# === Examples
#
#  class { 'postgresql::params': }
#
class postgresql::params {
  $package_name = 'postgresql'
}