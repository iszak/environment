# == Class: role::general
#
# A class to setup general server
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


  ufw::allow { 'ssh':
    service => 'ssh'
  }

  # ufw::default { 'deny incoming':
  #   type       => 'deny',
  #   connection => 'incoming'
  # }

  class { 'zsh': }
}
