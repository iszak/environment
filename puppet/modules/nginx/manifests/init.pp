# == Class: nginx
#
# A class to install nginx
#
# === Parameters
#
# [*owner*]
#   The owner of any files created, default is root
#
# [*group*]
#   The group of any files created, default is root
#
# [*sites_available*]
#   The path to sites available, default is /etc/nginx/sites-available/
#
# [*sites_enabled*]
#   The path to sites enabled, default is /etc/nginx/sites-enabled/
#
# [*default_site*]
#   Whether to create the default localhost site, default is true
#
# === Examples
#
#  class { 'nginx': }
#
class nginx (
  $owner           = undef,
  $group           = undef,

  $sites_available = undef,
  $sites_enabled   = undef,

  $default_site    = undef
) {
  include nginx::params

  $owner_param = $owner ? {
    undef   => $::nginx::params::owner,
    default => $owner,
  }

  $group_param = $group ? {
    undef   => $::nginx::params::group,
    default => $group,
  }

  $sites_available_param = $sites_available ? {
    undef   => $::nginx::params::sites_available,
    default => $sites_available,
  }

  $sites_enabled_param = $sites_enabled ? {
    undef   => $::nginx::params::sites_enabled,
    default => $sites_enabled,
  }

  $default_site_param = $default_site ? {
    undef   => $::nginx::params::default_site,
    default => $default_site,
  }


  package { 'nginx':
    ensure => latest
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }

  file { $sites_enabled_param:
    ensure  => directory,
    owner   => $owner_param,
    group   => $group_param,
    require => Package['nginx'],
  }

  file { $sites_available_param:
    ensure  => directory,
    owner   => $owner_param,
    group   => $group_param,
    require => Package['nginx'],
  }

  if $default_site_param == false {
    file { "${sites_enabled_param}/default":
      ensure => absent
    }

    file { "${sites_available_param}/default":
      ensure => absent
    }
  } else {
    # TODO: Set default site
    nginx::site { 'default':
        server_name => 'localhost',
        root        => '/usr/share/nginx/html',
    }
  }
}
