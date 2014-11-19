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
#   The hosts that the sudoer can connect from
#
# [*run_as_user*]
#   The user the sudoer can run as
#
# [*run_as_group*]
#   The group the sudoer can run as
#
# [*commands*]
#   The command the sudoer can run
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
  $run_as_user  = undef,
  $run_as_group = undef,
  $commands     = undef,
  $custom       = undef,

  $sudoers_file = undef,
  $sudoers_dir  = undef
) {
  include sudoers
  include sudoers::params

  $user_param = $user ? {
    undef   => $title,
    default => $user,
  }

  $hosts_param = $hosts ? {
    undef   => $::sudoers::params::sudoer_hosts,
    default => $hosts,
  }

  $run_as_user_param = $run_as_user ? {
    undef   => $::sudoers::params::sudoer_run_as_user,
    default => $run_as_user,
  }

  $run_as_group_param = $run_as_group ? {
    undef   => $::sudoers::params::sudoer_run_as_group,
    default => $run_as_group,
  }

  $commands_param = $commands ? {
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
    ensure  => present,
    require => Class['sudoers'],
    content => template('sudoers/sudoer.erb')
  }
}
