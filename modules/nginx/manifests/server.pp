# == Define: nginx::server
#
# A type to create nginx server blocks
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
#   The path to servers enabled, default is /etc/nginx/sites-enabled/
#
# [*sites_available*]
#   The path to servers available, default is /etc/nginx/sites-available/
#
# [*default_server*]
#   Whether this server is the default, default is false
#
# [*host*]
#   The host of the server, default is *
#
# [*port*]
#   The port of the server, default is 80
#
# [*index*]
#   The index to load, default is index.html and index.htm
#
# [*ipv6_only*]
#   Only use IPv6, default is false
#
# [*server_name*]
#   The server name, default is undefined
#
# [*root*]
#   The document root, default is undefined
#
# [*locations*]
#   The location declarations, default is empty array
#
# === Examples
#
#  nginx::site { 'localhost':
#      server_name => 'localhost',
#      root        => '/usr/share/nginx/html'
#  }
#
define nginx::server (
  $server_name,
  $root,

  $owner           = undef,
  $group           = undef,

  $sites_enabled   = undef,
  $sites_available = undef,

  $default_server  = false,

  $host            = undef,
  $port            = undef,
  $index           = undef,

  $ipv6_only       = undef,

  $locations       = undef,
  $error_pages     = undef,
) {
  include nginx
  include nginx::params

  $owner_param = $owner ? {
    undef   => $::nginx::params::owner,
    default => $owner,
  }

  $group_param = $group ? {
    undef   => $::nginx::params::group,
    default => $group,
  }

  $sites_enabled_param = $sites_enabled ? {
    undef   => $::nginx::params::sites_enabled,
    default => $sites_enabled,
  }

  $sites_available_param = $sites_available ? {
    undef   => $::nginx::params::sites_available,
    default => $sites_available,
  }

  $host_param = $host ? {
    undef   => $::nginx::params::host,
    default => $host,
  }

  $port_param = $port ? {
    undef   => $::nginx::params::port,
    default => $port,
  }

  $index_param = $index ? {
    undef   => $::nginx::params::index,
    default => $index,
  }

  $ipv6_only_param = $ipv6_only ? {
    undef   => $::nginx::params::ipv6_only,
    default => $ipv6_only,
  }

  $locations_param = $locations ? {
    undef   => $::nginx::params::locations,
    default => $locations,
  }

  $error_pages_param = $error_pages ? {
    undef   => $::nginx::params::error_pages,
    default => $error_pages,
  }


  $sites_enabled_path   = "${sites_enabled_param}/${name}"
  $sites_available_path = "${sites_available_param}/${name}"



  file { $sites_available_path:
    ensure  => present,
    content => template('nginx/server.erb'),
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
    notify  => Service['nginx'],
  }
}
