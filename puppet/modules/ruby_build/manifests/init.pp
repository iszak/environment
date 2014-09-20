# == Class: ruby_build
#
# A class to install ruby build
#
# === Parameters
#
# [*install_path*]
#   The path to install ruby build to
#
# [*repository_url*]
#   The url to the repository
#
# === Examples
#
#  class { 'ruby_build': }
#
class ruby_build (
  $install_path  = undef,
  $repository_url = undef
) {
  include rbenv
  include ruby_build::params
  include git

  $install_path_param = $install_path ? {
    undef   => $::ruby_build::params::install_path,
    default => $install_path,
  }

  $repository_url_param = $repository_url ? {
    undef   => $::ruby_build::params::repository_url,
    default => $repository_url,
  }

  package { [
    'autoconf',
    'bison',
    'build-essential',
    'libssl-dev',
    'libyaml-dev',
    'libreadline6-dev',
    'zlib1g-dev',
    'libncurses5-dev'
  ]:
    ensure => latest
  }

  exec { 'git clone ruby_build':
    command => "${::git::params::bin_path} clone ${repository_url_param} ${install_path_param}",
    creates => $install_path_param
  }

  exec { 'install ruby_build':
    require => Exec['git clone ruby_build'],
    command => "/bin/sh ${install_path_param}/install.sh",
    creates => '/usr/local/share/ruby-build/'
  }
}
