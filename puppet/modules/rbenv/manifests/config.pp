# == Class: rbenv::config
#
# A class to configure rbenv
#
# === Examples
#
#  class { 'rbenv::config': }
#
define rbenv::config (
  $download_path   = $::rbenv::params::download_path,
  $repository_path = $::rbenv::params::repository_url
) inherits ::rbenv::params {
  exec { 'install rbenv':
    require => Package['git'],
    command => "/bin/echo 'export PATH=\"${download_path}/bin:\$PATH\"'"
  }
}
