# == Class: rbenv::update
#
# A class to install update rbenv
#
# === Parameters
#
# [*install_path*]
#   The path to install rbenv to
#
# === Examples
#
#  class { 'rbenv::update': }
#
class rbenv::update (
  $install_path  = undef
) {
  include git
  include rbenv
  include rbenv::params

  $install_path_param = $install_path ? {
    undef   => $::rbenv::params::install_path,
    default => $install_path,
  }

  exec { 'git pull rbenv':
    require => [
      Package['git'],
      Class['rbenv'],
    ],
    command => "${::git::params::bin_path} pull",
    cwd     => $install_path_param
  }
}