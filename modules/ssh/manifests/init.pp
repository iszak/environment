# == Class: ssh
#
# A class to install ssh
#
# === Parameters
#
# [*client*]
#   Whether to install the SSH client
#
# [*client_package*]
#   The package name for SSH client
#
# [*server*]
#   Whether to install the SSH server
#
# [*server_package*]
#   The package name for SSH client
#
# === Examples
#
#  class { 'ssh': }
#
class ssh (
  $client         = undef,
  $client_package = undef,

  $server         = undef,
  $server_package = undef
) {
  include ssh::params

  $client_param = $client ? {
    undef   => $::ssh::params::client,
    default => $client,
  }

  $client_package_param = $client_package ? {
    undef   => $::ssh::params::client_package,
    default => $client_package,
  }


  $server_param = $server ? {
    undef   => $::ssh::params::server,
    default => $server,
  }

  $server_package_param = $server_package ? {
    undef   => $::ssh::params::server_package,
    default => $server_package,
  }


  if ($client_param == true) {
    package { $client_package_param:
      ensure => latest
    }
  }

  if ($server_param == true) {
    package { $server_package_param:
      ensure => latest
    }
  }

  if ($server_param == true) {
    service { 'ssh':
      ensure  => running,
      enable  => true,
      require => Package[$server_package_param],
    }
  }
}
