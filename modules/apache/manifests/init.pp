# == Class: apache
#
# A class to install apache
#
# === Parameters
#
# [*package_name*]
#   The package name to install
#
# [*owner*]
#   The owner of any files created, default is root
#
# [*group*]
#   The group of any files created, default is root
#
# [*sites_enabled*]
#   The path to virtual hosts enabled, default is /etc/apache2/sites-enabled/
#
# [*sites_available*]
#   The path to virtual hosts available, default is /etc/apache2/sites-available/
#
# === Examples
#
#  class { 'apache': }
#
class apache (
  $package_name    = undef,

  $owner           = undef,
  $group           = undef,

  $sites_enabled   = undef,
  $sites_available = undef,
) {
  include apache::params

  $package_name_param = $package_name ? {
    undef   => $::apache::params::package_name,
    default => $package_name,
  }


  $owner_param = $owner ? {
    undef   => $::apache::params::owner,
    default => $owner,
  }

  $group_param = $group ? {
    undef   => $::apache::params::group,
    default => $group,
  }


  $sites_enabled_param = $sites_enabled ? {
    undef   => $::apache::params::sites_enabled,
    default => $sites_enabled,
  }

  $sites_available_param = $sites_available ? {
    undef   => $::apache::params::sites_available,
    default => $sites_available,
  }


  package { $package_name_param:
    ensure => latest
  }

  service { 'apache':
    ensure  => running,
    name    => 'apache2',
    enable  => true,
    require => Package[$package_name_param],
  }

  file { $sites_enabled_param:
    ensure  => directory,
    owner   => $owner_param,
    group   => $group_param,
    require => Package[$package_name_param],
  }

  file { $sites_available_param:
    ensure  => directory,
    owner   => $owner_param,
    group   => $group_param,
    require => Package[$package_name_param],
  }
}
