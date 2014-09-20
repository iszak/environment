# == Class: sudoers::config
#
# A class to configure sudoers
#
# === Parameters
#
# [*user*]
#   The user, group, alias to create the sudo rule for
#
# [*hosts*]
#   The hosts that the user can connect from
#
# [*run_as*]
#   The members the user can run as
#
# [*commands*]
#   The command the user can run
#
# [*custom*]
#   A custom fragment
#
# [*sudoers_file*]
#   The path to the sudoers file
#
# [*sudoers_dir*]
#   The path to the sudoers directory
#
# === Examples
#
#  sudoers::config { "iszak" }
#
define sudoers::config (
  $user         = undef,
  $hosts        = undef,
  $run_as       = undef,
  $commands     = undef,
  $custom       = undef,

  $sudoers_file = undef,
  $sudoers_dir  = undef
) {
  include sudoers
  include sudoers::params

  if $user == undef {
    $user_param = $name
  }

  $hosts_param = $hosts ? {
    undef   => $::sudoers::params::sudoer_hosts,
    default => $hosts,
  }

  $run_as_param = $run_as ? {
    undef   => $::sudoers::params::sudoer_run_as,
    default => $run_as,
  }

  $commands_param = $comamnds ? {
    undef   => $::sudoers::params::sudoers_commands,
    default => $commands,
  }

  $sudoers_file_param = $sudoers_file ? {
    undef   => $::sudoers::params::sudoers_file,
    default => $sudoers_file,
  }

  $sudoers_dir_param = $sudoers_dir ? {
    undef   => $::sudoers::params::sudoers_dir,
    default => $sudoers_dir,
  }

  file { "${sudoers_dir_param}/${name}":
    require => Class['sudoers'],
    ensure  => present,
    content => template('sudoers/sudoer.erb')
  }
}
