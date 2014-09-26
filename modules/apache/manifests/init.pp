# == Class: apache
#
# A class to install apache
#
# === Parameters
#
# [*package_name*]
#   The package name to install
#
# === Examples
#
#  class { 'apache': }
#
class apache (
  $package_name = undef
) {
  include apache::params

  $package_name_param = $package_name ? {
    undef   => $::apache::params::package_name,
    default => $package_name,
  }


  package { $package_name_param:
    ensure => latest
  }

  service { 'apache2':
    ensure  => running,
    enable  => true,
    require => Package[$package_name_param],
  }
}
