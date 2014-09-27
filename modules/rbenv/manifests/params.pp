# == Class: rbenv::params
#
# A class to set the default parameters of rbenv
#
# === Examples
#
#  class { 'rbenv::params': }
#
class rbenv::params {
  $repository_url  = 'https://github.com/sstephenson/rbenv.git'

  $install_path    = '/usr/local/rbenv'
  $bin_path        = "${install_path}/bin/rbenv"

  $version_path    = "${install_path}/versions"

  $build_timeout   = 900
}
