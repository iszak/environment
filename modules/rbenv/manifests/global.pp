# == Class: rbenv::global
#
# A class to set the global ruby version
#
# === Parameters
#
# [*version*]
#   The version to set the global ruby as
#
# [*rbenv_root*]
#   The rbenv root for installing ruby
#
# === Examples
#
#  class { 'rbenv::global':
#    version => '2.1.3'
#  }
#
class rbenv::global (
  $version    = undef,
  $rbenv_root = undef
) {
  include rbenv
  include rbenv::params

  $version_param = $version ? {
    undef   => $::rbenv::params::global_version,
    default => $version,
  }

  $rbenv_root_param = $rbenv_root ? {
    undef   => $::rbenv::params::install_path,
    default => $rbenv_root,
  }

  exec { "rbenv global":
    require     => Exec['install rbenv'],
    command     => "${::rbenv::params::bin_path} global ${version_param}",
    environment => ["RBENV_ROOT=${rbenv_root_param}"],
  }
}
