# == Class: ruby_build::update
#
# A class to install update ruby build
#
# === Parameters
#
# [*install_path*]
#   The path to install ruby build to
#
# === Examples
#
#  class { 'ruby_build::update': }
#
class ruby_build::update (
  $install_path  = undef
) {
  include git
  include ruby_build
  include ruby_build::params

  $install_path_param = $install_path ? {
    undef   => $::ruby_build::params::install_path,
    default => $install_path,
  }


  exec { 'git pull ruby_build':
    require => [
      Class['ruby_build'],
      Package['git'],
    ],
    command => "${::git::params::bin_path} pull",
    cwd     => $install_path_param
  }
}
