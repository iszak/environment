node default {
  include role::general
  include role::backup
  include role::web
  # include role::php
  include role::ruby
  include role::database

  project::rails { '1001-beers-api':
    user  => 'beers-api',
    group => 'beers-api',
    url   => 'https://github.com/iszak/1001-beers-api.git',
    path  => '/home/beers-api/public_html/'
  }

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
