# == Class: hostname
#
# A class to install hostname
#
# === Examples
#
#  class { 'hostname':
#    name => 'beers'
#  }
#
class hostname {
  include hostname::params

  file { $::hostname::params::hostname_file:
    ensure  => present,
    content => $name
  }
}
