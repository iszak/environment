# == Class: ufw
#
# A class to install ufw
#
# === Parameters
#
# [*enable*]
#   Whether to enable or disable ufw
#
# [*logging*]
#   Whether to enable or disable logging
#
# [*bin_path*]
#   The path to the ufw binary
#
# [*package_name*]
#   The package name to install
#
# === Examples
#
#  class { 'ufw': }
#
class ufw (
  $enable       = undef,
  $logging      = undef,
  $bin_path     = undef,
  $package_name = undef
) {
  include ufw::params

  $enable_param = $enable ? {
    undef   => $::ufw::params::enable,
    default => $enable,
  }

  $logging_param = $logging ? {
    undef   => $::ufw::params::logging,
    default => $logging,
  }

  $bin_path_param = $bin_path ? {
    undef   => $::ufw::params::bin_path,
    default => $bin_path,
  }

  $package_name_param = $package_name ? {
    undef   => $::ufw::params::package_name,
    default => $package_name,
  }


  package { $package_name_param:
    ensure => latest
  }

  if ($enable_param == true) {
    exec { 'ufw enable':
      command => "/bin/echo \"y\" | ${bin_path_param} enable",
      require => Package['ufw']
    }
  } else {
    exec { 'ufw disable':
      command => "${bin_path_param} disable",
      require => Package['ufw']
    }
  }

  if ($logging == true) {
    exec { 'ufw logging on':
      command => "${bin_path_param} logging on",
      require => Package['ufw']
    }
  } else {
    exec { 'ufw logging off':
      command => "${bin_path_param} logging off",
      require => Package['ufw']
    }
  }
}
