# == Class: postgresql
#
# A class to install PostgreSQL
#
# === Parameters
#
# [*package_name*]
#   The package name to install
#
# === Examples
#
#  class { 'postgresql': }
#
class postgresql (
  $package_name = undef
) {
  include postgresql::params

  $package_name_param = $package_name ? {
    undef   => $::postgresql::params::package_name,
    default => $package_name,
  }


  package { $package_name_param:
    ensure => latest
  }

  service { 'postgresql':
    ensure  => running,
    enable  => true,
    require => Package[$package_name_param],
  }
}
