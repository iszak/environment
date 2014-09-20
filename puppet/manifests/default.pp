node default {
  stage { 'init':
    before => Stage['main']
  }

  # Apt
  class { 'apt':
    stage => init
  }

  # Nginx
  class { 'nginx': }

  nginx::site { 'test':
    server_name => 'localhost',
    root        => '/usr/share/nginx/html',
  }

  # Zsh
  class { 'zsh': }


  # PHP
  class { 'php':
    implementation => 'fpm'
  }

  php::module { 'intl': }


  # Ruby
  class { 'rbenv': }
  class { 'rbenv::update': }

  # rbenv::install { '2.1.2': }


  class { 'ruby_build': }

  class { 'ruby_build::update': }

  ruby::gem { 'bundler': }



  # Iszak user
  user { 'iszak':
    require    => Class['zsh'],
    ensure     => present,
    managehome => true,
    shell      => '/bin/zsh'
  }

  zsh::config { 'iszak':
    require => User['iszak'],
  }

  sudoers::config { 'iszak':
    require => User['iszak'],
    custom  => 'iszak ALL=(ALL) NOPASSWD:ALL'
  }


  # Miscellaneous
  package { 'language-pack-en':
    ensure => latest
  }
}
