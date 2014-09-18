# == Class: rbenv
#
# A class to install rbenv
#
# === Parameters
#
# [*install_path*]
#   The path to install rbenv to, default is /usr/local/rbenv
#
# [*repository_url*]
#   The url to the repository, default is https://github.com/sstephenson/rbenv.git
#
# === Examples
#
#  class { 'rbenv': }
#
class rbenv (
  $install_path  = undef,
  $repository_url = undef
) {
  include rbenv::params
  include git

  $install_path_param = $install_path ? {
    undef   => $::rbenv::params::install_path,
    default => $install_path,
  }

  $repository_url_param = $repository_url ? {
    undef   => $::rbenv::params::repository_url,
    default => $repository_url,
  }


  exec { 'git clone rbenv':
    require => Package['git'],
    command => "${::git::params::bin_path} clone ${repository_url_param} ${install_path_param}",
    creates => $install_path_param
  }
}
