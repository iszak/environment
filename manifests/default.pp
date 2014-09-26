node default {
  stage { 'init':
    before => Stage['main']
  }


  # Apt
  class { 'apt':
    stage => init
  }

  # class { 'crashplan': }


  # Apache
  class { 'apache': }

  apache::module { 'xsendfile': }
  apache::module { 'passenger': }


  # Zsh
  class { 'zsh': }


  # PHP
  class { 'php':
    package_name => 'fpm'
  }

  # Ruby
  class { 'rbenv': }
  class { 'rbenv::update': }

  # rbenv::install { '2.1.2': }


  class { 'ruby_build': }

  class { 'ruby_build::update': }

  ruby::gem { 'bundler': }


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


  # Miscellaneous
  package { 'language-pack-en':
    ensure => latest
  }
}
