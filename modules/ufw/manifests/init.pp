# == Class: ufw
#
# A class to install ufw
#
# === Parameters
#
# === Examples
#
#  class { 'ufw': }
#
class ufw (
  $enable  = undef,
  $logging = undef
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

  package { 'ufw':
    ensure => latest
  }

  if ($enable == true) {
    exec { 'ufw enable':
      require => Package['ufw']
    }
  } else {
    exec { 'ufw disable':
      require => Package['ufw']
    }
  }

  if ($logging == true) {
    exec { 'ufw logging on':
      require => Package['ufw']
    }
  } else {
    exec { 'ufw logging off':
      require => Package['ufw']
    }
  }
}
