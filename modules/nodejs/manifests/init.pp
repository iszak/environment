# == Class: nodejs
#
# A class to install nodejs
#
# === Parameters
#
# [*debug*]
#   Whether to install the debug package
#
# [*development*]
#   Whether to install the development package
#
# === Examples
#
#  class { 'nodejs': }
#
class nodejs (
  $debug       = undef,
  $development = undef
) {
  package { 'nodejs':
    ensure => latest
  }

  if $debug == true {
    package { 'nodejs-dbg':
      ensure => latest
    }
  }

  if $development == true {
    package { 'nodejs-dev':
      ensure => latest
    }
  }
}
