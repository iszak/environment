# == Define: nginx::site
#
# A type to create nginx sites
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
# [*default_server*]
#   Whether this site is the default server, default is false
#
# [*host*]
#   The host of the site, default is *
#
# [*port*]
#   The port of the site, default is 80
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
define nginx::site (
  $server_name,
  $root,

  $owner           = $::nginx::params::owner,
  $group           = $::nginx::params::group,

  $sites_enabled   = $::nginx::params::sites_enabled,
  $sites_available = $::nginx::params::sites_available,

  $default_server  = false,

  $host            = $::nginx::params::host,
  $port            = $::nginx::params::port,
  $index           = $::nginx::params::index,

  $ipv6_only       = $::nginx::params::ipv6_only,

  $locations       = $::nginx::params::locations,
) {
  if defined(Class['nginx']) == false {
    fail('You must include the nginx base class')
  }

  $sites_enabled_path   = "${sites_enabled}/${name}"
  $sites_available_path = "${sites_available}/${name}"



  file { $sites_available_path:
    ensure  => present,
    content => template('nginx/site.erb'),
    owner   => $owner,
    group   => $group,
    require => File[$sites_available],
  }

  file { $sites_enabled_path:
    ensure  => link,
    target  => $sites_available_path,
    require => [
      File[$sites_available],
      File[$sites_available_path]
    ],
  }
}
