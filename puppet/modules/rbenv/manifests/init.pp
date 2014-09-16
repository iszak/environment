# == Class: rbenv
#
# A class to install rbenv
#
# === Parameters
#
# [*download_path*]
#   The path to download rbenv to, default is /tmp/rbenv
#
# [*repository_path*]
#   The url to the repository, default is https://github.com/sstephenson/rbenv.git
#
# === Examples
#
#  class { 'rbenv': }
#
class rbenv (
  $download_path  = undef,
  $repository_url = undef
) {
  include rbenv::params
  include git

  $download_path_param = $download_path ? {
    undef   => $::rbenv::params::download_path,
    default => $download_path,
  }

  $repository_url_param = $repository_url ? {
    undef   => $::rbenv::params::repository_url,
    default => $repository_url,
  }


  exec { 'git clone rbenv':
    require => Package['git'],
    command => "${::git::params::bin_path} clone ${repository_url_param} ${download_path_param}",
    creates => $download_path_param
  }
}
