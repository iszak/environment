# == Class: apt
#
# A class to manage apt
#
# === Parameters
#
# [*update*]
#   The mode to run apt-get update, options are never, always, once
#
# [*upgrade*]
#   The mode to run apt-get upgrade, options are never, always, once
#
# [*unattended_upgrades]
#   Whether to install upgrades unattended periodically
#
# === Examples
#
#  class { 'apt': }
#
class apt (
  $update              = undef,
  $upgrade             = undef,

  $unattended_upgrades = undef
) {
  include apt::params

  $update_param = $update ? {
    undef   => $::apt::params::update,
    default => $update,
  }

  $upgrade_param = $upgrade ? {
    undef   => $::apt::params::upgrade,
    default => $upgrade,
  }

  $unattended_upgrades_param = $unattended_upgrades ? {
    undef   => $::apt::params::unattended_upgrades,
    default => $unattended_upgrades,
  }


  # Run apt-get update once
  if $update_param == 'once' {
    $update_lock = '/var/lock/apt-get-update'

    exec { 'apt-get update lock':
      command => "/usr/bin/touch ${update_lock}",
      creates => $update_lock,
      notify  => Exec['apt-get update'],
    }
  }

  # Run apt-get update
  if $update_param == 'once' or
     $update_param == 'always' {
    exec { 'apt-get update':
      command     => '/usr/bin/apt-get update',
      refreshonly => ($update_param == 'once')
    }

    Exec['apt-get update'] -> Package <| |>
  }



  # Run apt-get upgrade only once
  if $upgrade_param == 'once' {
    $upgrade_lock = '/var/lock/apt-get-upgrade'

    exec { 'apt-get upgrade lock':
      command => "/usr/bin/touch ${upgrade_lock}",
      creates => $upgrade_lock,
      notify  => Exec['apt-get upgrade'],
    }
  }

  # Require apt-get update before upgrade
  if $update_param != 'none' {
    $upgrade_require = Exec['apt-get update']
  }

  # Run apt-get upgrade
  if $upgrade_param == 'once' or
     $upgrade_param == 'always' {
    exec { 'apt-get upgrade':
      require     => $upgrade_require,
      command     => '/usr/bin/apt-get upgrade --yes',
      refreshonly => ($upgrade_param == 'once')
    }

    Exec['apt-get upgrade'] -> Package <| |>
  }


  if $unattended_upgrades_param == true {
    file { 'auto upgrades':
      ensure  => present,
      path    => '/etc/apt/apt.conf.d/20auto-upgrades',
      content => template('apt/auto-upgrades.erb')
    }

    file { '/etc/apt/apt.conf.d/50unattended-upgrades':
      ensure  => present,
      content => template('apt/unattended-upgrades.erb')
    }
  }
}
