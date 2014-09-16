# == Class: ruby_build::params
#
# A class to configure ruby build
#
# === Examples
#
#  class { 'ruby_build::params': }
#
class ruby_build::params {
  $download_path  = '/tmp/ruby-build'
  $repository_url = 'https://github.com/sstephenson/ruby-build.git'
}
