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
  $download_path  = $::ruby_build::params::download_path,
  $repository_url = $::ruby_build::params::repository_url
) inherits ::ruby_build::params {
  include git

  exec { 'git clone ruby-build':
    require => Package['git'],
    command =>
      "${::git::params::bin_path} clone ${repository_url} ${download_path}",
    creates => $download_path
  }

  exec { 'install ruby-build':
    require => Exec['git clone ruby-build'],
    command => "/bin/sh ${download_path}/install.sh"
  }
}
