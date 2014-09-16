# == Class: ruby_build
#
# A class to install ruby build
#
# === Parameters
#
# [*download_path*]
#   The path to download ruby-build to, default is /tmp/ruby-build
#
# [*repository_path*]
#   The url to the repository, default is https://github.com/sstephenson/ruby-build.git
#
# === Examples
#
#  class { 'ruby_build': }
#
class ruby_build (
  $download_path  = undef,
  $repository_url = undef
) {
  include ruby_build::params
  include git

  $download_path_param = $download_path ? {
    undef   => $::ruby_build::params::download_path,
    default => $download_path,
  }

  $repository_url_param = $repository_url ? {
    undef   => $::ruby_build::params::repository_url,
    default => $repository_url,
  }


  exec { 'git clone ruby-build':
    require => Package['git'],
    command => "${::git::params::bin_path} clone ${repository_url_param} ${download_path_param}",
    creates => $download_path_param
  }

  exec { 'install ruby-build':
    require => Exec['git clone ruby-build'],
    command => "/bin/sh ${download_path_param}/install.sh"
  }
}
