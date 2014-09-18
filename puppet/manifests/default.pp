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


  class { 'php':
    implementation => 'fpm'
  }

  zsh::config { 'vagrant':

  }

  class { 'rbenv':

  }

  class { 'ruby_build':

  }


  package { 'language-pack-en':
    ensure => latest
  }
}
