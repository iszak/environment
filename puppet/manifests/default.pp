node default {
  stage { 'init':
    before => Stage['main']
  }

  class { 'apt':
    stage => init
  }

  class { 'nginx':

  }

  nginx::site { 'test':
    require     => Class['nginx'],
    server_name => 'localhost',
    root        => '/usr/share/nginx/html',
  }

  class { 'zsh':
  }

  zsh::config { 'vagrant':
    require => Class['zsh']
  }


  class { 'php':
    implementation => 'fpm'
  }


  class { 'rbenv':

  }

  rbenv::config { 'vagrant':
    require => Class['rbenv']
  }

  rbenv::install { '2.1.0':
    require => [
      Class['rbenv'],
      Class['ruby_build']
    ]
  }


  class { 'ruby_build':
    require => Class['rbenv']
  }


  package { 'language-pack-en':
    ensure => latest
  }
}
