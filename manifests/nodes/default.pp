node default {
  include role::general
  include role::web
  include role::ruby
  include role::database


  # User
  user { 'iszak':
    ensure     => present,
    require    => Class['zsh'],
    managehome => true,
    shell      => '/bin/zsh'
  }

  zsh::config { 'iszak':
    require => User['iszak'],
  }

  sudoers::config { 'iszak':
    require => User['iszak']
  }
}
