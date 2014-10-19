# == Class: git::params
#
# A class to set the default parameters of git
#
# === Examples
#
#  class { 'git::params': }
#
class git::params {
  $bin_path = '/usr/bin/git'

  $clone_user  = 'root'
  $clone_group = 'root'
  $clone_depth = 1
}
