# == Class: ruby_build::params
#
# A class to set the default parameters of ruby build
#
# === Examples
#
#  class { 'ruby_build::params': }
#
class ruby_build::params {
  $repository_url   = 'https://github.com/sstephenson/ruby-build.git'

  $install_path     = '/usr/local/rbenv/plugins/ruby-build'
  $bin_path         = "${install_path}/bin/ruby"

  $build_path       = '/usr/local/rbenv/versions'
  $build_timeout    = 900
}
