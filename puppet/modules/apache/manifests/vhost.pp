# == Define: apache::vhost
#
# A type to create apache virtual host
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
#   The path to virtual hosts enabled, default is /etc/apache2sites-enabled/
#
# [*sites_available*]
#   The path to virtual hosts available, default is /etc/apache2sites-available/
#
# [*host*]
#   The host of the server, default is all
#
# [*port*]
#   The port of the server, default is 80
#
# [*server_name*]
#   The server name, default is undefined
#
# === Examples
#
#  apache::vhost { 'localhost':
#      server_name   => 'localhost',
#      document_root => '/var/www/'
#  }
#
define apache::vhost (
  $server_name,
  $document_root,

  $owner           = $::apache::params::owner,
  $group           = $::apache::params::group,

  $sites_enabled   = $::apache::params::sites_enabled,
  $sites_available = $::apache::params::sites_available,

  $host            = $::apache::params::host,
  $port            = $::apache::params::port,

  $ipv6_only       = $::nginx::params::ipv6_only
) {
  include apache
  include apache::params

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

  $host_param = $host ? {
    undef   => $::apache::params::host,
    default => $host,
  }

  $port_param = $port ? {
    undef   => $::apache::params::port,
    default => $port,
  }

  $sites_enabled_path   = "${sites_enabled_param}/${name}"
  $sites_available_path = "${sites_available_param}/${name}"



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