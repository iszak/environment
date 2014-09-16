# == Class: rbenv::params
#
# A class to set the default parameters of rbenv
#
# === Examples
#
#  class { 'rbenv::params': }
#
class rbenv::params {
    $download_path  = '/tmp/rbenv'
    $repository_url = 'https://github.com/sstephenson/rbenv.git'
}