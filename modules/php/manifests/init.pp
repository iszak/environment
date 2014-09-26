# == Class: php
#
# A class to install php
#
# === Parameters
#
# [*package_prefix*]
#   The package prefix to use
#
# [*package_name*]
#   The name of PHP to use
#
# === Examples
#
#  class { 'php': }
#
class php (
  $package_prefix = undef,
  $package_name = undef
) {
  include php::params

  $package_prefix_param = $package_prefix ? {
    undef   => $::php::params::package_prefix,
    default => $package_prefix,
  }

  $package_name_param = $package_name ? {
    undef   => $::php::params::package_name,
    default => $package_name,
  }


  package { "${package_prefix_param}-${package_name_param}":
    ensure => latest
  }
}
