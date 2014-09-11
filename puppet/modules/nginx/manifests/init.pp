class nginx (
    $owner           = $::nginx::params::owner,
    $group           = $::nginx::params::group,

    $sites_enabled   = $::nginx::params::sites_enabled,
    $sites_available = $::nginx::params::sites_available,
) inherits ::nginx::params {
    package { 'nginx':
        ensure => latest
    }

    service { 'nginx':
        require => Package['nginx'],
        ensure  => 'running',
        enable  => 'true',
    }

    file { $sites_enabled:
        require => Package['nginx'],
        ensure  => directory,
        owner   => $owner,
        group   => $group,
    }

    file { $sites_available:
        require => Package['nginx'],
        ensure  => directory,
        owner   => $owner,
        group   => $group,
    }

    if $default_site == false {
        file { "${sites_enabled}/default":
            ensure => absent
        }

        file { "${sites_available}/default":
            ensure => absent
        }
    } else {
        # TODO: Set default site
        nginx::site { 'default':
            server_name => 'localhost',
            root        => '/usr/share/nginx/html'
        }
    }
}
