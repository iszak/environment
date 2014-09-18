# == Class: apt
#
# A class to manage apt
#
# === Parameters
#
# [*always_update*]
#   Always run apt-get update before installing any packages
#
# [*always_upgrade*]
#   Always run apt-get upgrade before installing any packages
#
# [*upgrade_once*]
#   Only run apt-get upgrade once
#
# === Examples
#
#  class { 'apt': }
#
class apt (
  $always_update  = undef,
  $always_upgrade = undef,
  $upgrade_once   = undef
) {
  include apt::params

  $always_update_param = $always_update ? {
    undef   => $::apt::params::always_update,
    default => $always_update,
  }

  $always_upgrade_param = $always_upgrade ? {
    undef   => $::apt::params::always_upgrade,
    default => $always_upgrade,
  }

  $upgrade_once_param = $upgrade_once ? {
    undef   => $::apt::params::upgrade_once,
    default => $upgrade_once,
  }


  if $always_update_param == true {
    exec { 'apt-get update':
      command => '/usr/bin/apt-get update'
    }

    Exec['apt-get update'] -> Package <| |>
  }

  if $always_upgrade_param == true {
    $upgrade_lock = '/var/lock/apt-get-upgrade'

    if $always_update_param == true {
      $upgrade_require = Exec['apt-get update']
    }

    exec { 'apt-get upgrade':
      require     => $upgrade_require,
      command     => '/usr/bin/apt-get upgrade --yes',
      refreshonly => $upgrade_once_param
    }

    if $upgrade_once_param {
      exec { 'apt-get upgrade lock':
        command => "/usr/bin/touch ${upgrade_lock}",
        creates => $upgrade_lock,
        notify  => Exec['apt-get upgrade'],
      }
    }

    Exec['apt-get upgrade'] -> Package <| |>
  }
}
