node default {
  stage { 'init':
    before => Stage['main']
  }

  class { 'apt':
    stage => init
  }

  class { 'nginx':

  }

  class { 'memcached':

  }

  nginx::site { 'test':
    server_name => 'localhost',
    root        => '/usr/share/nginx/html',
  }

  class { 'zsh':}

  zsh::config { 'vagrant':
    require => Class['zsh']
  }


  class { 'php':
    implementation => 'fpm'
  }

  php::module { 'intl':
    require => Class['php']
  }


  class { 'rbenv': }
  class { 'rbenv::update': }

  rbenv::config { 'vagrant':
    require => [
      Class['rbenv'],
      zsh::config['vagrant']
    ]
  }

  rbenv::install { '2.1.2':
    require => [
      Class['rbenv'],
      Class['ruby_build']
    ]
  }


  class { 'ruby_build':
    require => Class['rbenv']
  }
  class { 'ruby_build::update': }

  ruby::gem { 'bundler': }

  package { 'language-pack-en':
    ensure => latest
  }

  class { 'sudoers': }

  sudoers::config { 'iszak':
    custom => 'iszak ALL=(ALL) NOPASSWD:ALL'
  }
}
