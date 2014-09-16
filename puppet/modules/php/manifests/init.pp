# == Class: php
#
# A class to install php
#
# === Parameters
#
# [*package_prefix*]
#   The package prefix to use, default is php5-
#
# [*implementation*]
#   The implement of PHP to use, default is FPM
#
# === Examples
#
#  class { 'php': }
#
class php (
  $package_prefix = $::php::params::package_prefix,
  $implementation = $::php::params::implementation
) inherits ::php::params {
  case $implementation {
    'fpm': {
      $package_name = "${package_prefix}-fpm"
    }
    default: {
      fail('Implementation not supported')
    }
  }

  package { 'php':
    ensure => latest,
    name   => $package_name
  }
}
