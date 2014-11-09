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
# [*cli*]
#   Whether to install CLI packages
#
# [*dev*]
#   Whether to install development packages
#
# === Examples
#
#  class { 'php': }
#
class php (
  $package_prefix = undef,
  $package_name   = undef,
  $cli            = undef,
  $dev            = undef,
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

  $cli_param = $cli ? {
    undef   => $::php::params::cli,
    default => $cli,
  }

  $dev_param = $dev ? {
    undef   => $::php::params::dev,
    default => $dev,
  }

  if ($cli_param == true) {
    package { "${package_prefix_param}-cli":
      ensure => latest
    }
  }

  if ($dev_param == true) {
    package { "${package_prefix_param}-dev":
      ensure => latest
    }
  }

  package { "${package_prefix_param}-${package_name_param}":
    ensure => latest
  }
}
