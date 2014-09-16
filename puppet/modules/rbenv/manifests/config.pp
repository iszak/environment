# == Class: rbenv::config
#
# A class to configure rbenv
#
# === Examples
#
#  rbenv::config { "iszak" }
#
define rbenv::config () {
  include rbenv::params

  exec { 'install rbenv':
    require => Package['git'],
    command => "/bin/echo 'export PATH=\"${::rbenv::params::download_path}/bin:\$PATH\"'"
  }
}
