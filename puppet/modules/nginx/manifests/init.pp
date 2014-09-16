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
# [*sites_enabled*]
#   The path to sites enabled, default is /etc/nginx/sites-enabled/
#
# [*sites_available*]
#   The path to sites available, default is /etc/nginx/sites-available/
#
# [*default_site*]
#   Whether to create the default localhost site, default is true
#
# === Examples
#
#  class { 'nginx': }
#
class nginx (
  $owner           = $::nginx::params::owner,
  $group           = $::nginx::params::group,

  $sites_enabled   = $::nginx::params::sites_enabled,
  $sites_available = $::nginx::params::sites_available,

  $default_site    = true
) inherits ::nginx::params {
  package { 'nginx':
    ensure => latest
  }

  service { 'nginx':
    ensure  => 'running',
    enable  => true,
    require => Package['nginx'],
  }

  file { $sites_enabled:
    ensure  => directory,
    owner   => $owner,
    group   => $group,
    require => Package['nginx'],
  }

  file { $sites_available:
    ensure  => directory,
    owner   => $owner,
    group   => $group,
    require => Package['nginx'],
  }

  if $default_site == false {
    file { "${sites_enabled}/default":
      ensure => absent
    }

    file { "${sites_available}/default":
      ensure => absent
    }
  } else {
    # TODO: Set default site
    nginx::site { 'default':
        server_name => 'localhost',
        root        => '/usr/share/nginx/html'
    }
  }
}
