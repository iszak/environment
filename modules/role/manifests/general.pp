# == Class: role::general
#
# A class to setup general
#
# === Parameters
#
# === Examples
#
#  include role::general
#
class role::general {
  stage { 'init':
    before => Stage['main']
  }

  class { 'apt':
    stage => init
  }

  class { 'i18n':
    stage   => init,
    require => Class['apt']
  }

  class { 'ufw': }

  ufw::allow { 'ssh': }

  class { 'zsh': }
}
