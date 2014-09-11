define nginx::site (
    $owner           = $::nginx::params::owner,
    $group           = $::nginx::params::group,

    $sites_enabled   = $::nginx::params::sites_enabled,
    $sites_available = $::nginx::params::sites_available,

    $default_server  = false,

    $host            = $::nginx::params::host,
    $port            = $::nginx::params::port,
    $index           = $::nginx::params::index,

    $ipv6_only       = $::nginx::params::ipv6_only,

    $server_name,
    $root,
) {
    if defined(Class['nginx']) == false {
        fail('You must include the nginx base class before using any nginx defined resources')
    }

    $sites_enabled_path   = "${sites_enabled}/${name}"
    $sites_available_path = "${sites_available}/${name}"



    file { $sites_available_path:
        require => File[$sites_available],
        ensure  => present,
        content => template('nginx/site.erb'),
        owner   => $owner,
        group   => $group,
    }

    file { $sites_enabled_path:
        require => [
            File[$sites_available],
            File[$sites_available_path]
        ],
        ensure  => link,
        target  => $sites_available_path,
    }
}
