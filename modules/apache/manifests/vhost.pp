# == Define: apache::vhost
#
# A type to create apache virtual host
#
# === Parameters
#
# [*priority*]
#   The load priority of the server, default is 20
#
# [*host*]
#   The host of the server, default is all
#
# [*port*]
#   The port of the server, default is 80
#
#
# [*server_name*]
#   The server name, default is undefined
#
# [*document_root*]
#   The document root
#
#
# [*owner*]
#   The owner of any files created, default is root
#
# [*group*]
#   The group of any files created, default is root
#
# [*sites_enabled*]
#   The path to virtual hosts enabled, default is /etc/nginx/sites-enabled/
#
# [*sites_available*]
#   The path to virtual hosts available, default is /etc/nginx/sites-available/
#
# === Examples
#
#  apache::vhost { 'localhost':
#      server_name   => 'localhost',
#      document_root => '/var/www/'
#  }
#
define apache::vhost (
  $priority        = undef,

  $host            = undef,
  $port            = undef,

  $server_name     = undef,
  $document_root   = undef,

  $owner           = undef,
  $group           = undef,

  $sites_enabled   = undef,
  $sites_available = undef,
) {
  include apache
  include apache::params

  $priority_param = $priority ? {
    undef   => $::apache::params::priority,
    default => $priority,
  }

  $host_param = $host ? {
    undef   => $::apache::params::host,
    default => $host,
  }

  $port_param = $port ? {
    undef   => $::apache::params::port,
    default => $port,
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


  $sites_enabled_path   = "${sites_enabled_param}/${priority_param}-${name}.conf"
  $sites_available_path = "${sites_available_param}/${priority_param}-${name}.conf"



  file { $sites_available_path:
    ensure  => present,
    content => template('apache/vhost.erb'),
    owner   => $owner_param,
    group   => $group_param,
    require => File[$sites_available_param],
  }

  file { $sites_enabled_path:
    ensure  => link,
    target  => $sites_available_path,
    require => [
      File[$sites_available_param],
      File[$sites_available_path]
    ],
    notify  => Service['apache'],
  }
}
