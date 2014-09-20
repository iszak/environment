# == Class: sudoers::params
#
# A class to set the default parameters of sudoers
#
# === Examples
#
#  class { 'sudoers::params': }
#
class sudoers::params {
  $sudoers_file = '/etc/sudoers'
  $sudoers_dir  = '/etc/sudoers.d'

  $sudoer_hosts     = ['ALL']
  $sudoer_run_as    = ['ALL']
  $sudoers_commands = ['ALL']
}
