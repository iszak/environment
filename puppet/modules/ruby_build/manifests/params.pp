# == Class: ruby_build::params
#
# A class to set the default parameters of ruby build
#
# === Examples
#
#  class { 'ruby_build::params': }
#
class ruby_build::params {
  $install_path     = '/usr/local/rbenv/plugins/ruby-build'
  $repository_url   = 'https://github.com/sstephenson/ruby-build.git'

  $destination_path = '/usr/local/rbenv/versions'
  $install_timeout  = 1200
}
