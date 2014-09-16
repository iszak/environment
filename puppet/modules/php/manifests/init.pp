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
  $package_prefix = undef,
  $implementation = undef
) {
  include php::params

  $package_prefix_param = $package_prefix ? {
    undef   => $::php::params::package_prefix,
    default => $package_prefix,
  }

  $implementation_param = $implementation ? {
    undef   => $::php::params::implementation,
    default => $implementation,
  }


  case $implementation_param {
    'fpm': {
      $package_name = "${package_prefix_param}-fpm"
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
