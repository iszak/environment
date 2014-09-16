# == Class: php::params
#
# A class to set the default parameters of php
#
# === Examples
#
#  class { 'php::params': }
#
class php::params {
  $package_prefix = 'php5'
  $package_name   = 'fpm'
}
