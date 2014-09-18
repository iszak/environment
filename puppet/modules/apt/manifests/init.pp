# == Class: apt
#
# A class to manage apt
#
# === Parameters
#
# [*package_prefix*]
#   The package prefix to use, default is php5-
#
# [*implementation*]
#   The implement of PHP to use, default is FPM
#
# === Examples
#
#  class { 'apt': }
#
class apt (
  $always_update = undef
) {
  include apt::params

  $always_update_param = $always_update ? {
    undef   => $::apt::params::always_update,
    default => $always_update,
  }

  if $always_update_param == true {
    exec { 'apt-update':
      command => '/usr/bin/apt-get update'
    }

    Exec['apt-update'] -> Package <| |>
  }
}
