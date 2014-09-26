# == Class: sudoers
#
# A class to setup sudoers
#
# === Parameters
#
# [*sudoers_file*]
#   The path to the sudoers file
#
# [*sudoers_dir*]
#   The path to the sudoers directory
#
# === Examples
#
#  class { 'sudoers': }
#
class sudoers (
  $sudoers_file = undef,
  $sudoers_dir = undef
) {
  include sudoers::params

  $sudoers_file_param = $sudoers_file ? {
    undef   => $::sudoers::params::sudoers_file,
    default => $sudoers_file,
  }

  $sudoers_dir_param = $sudoers_dir ? {
    undef   => $::sudoers::params::sudoers_dir,
    default => $sudoers_dir,
  }


  file { $sudoers_file_param:
    ensure  => present,
    content => template('sudoers/sudoers.erb')
  }

  file { $sudoers_dir_param:
    ensure => directory
  }
}
