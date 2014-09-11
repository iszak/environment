class php (
    $package_prefix = $::php::params::package_prefix,
    $implementation = $::php::params::implementation
) inherits ::php::params {
    case $implementation {
        'fpm': {
            $package_name = "${package_prefix}-fpm"
        }
        default: {
            fail("Implementation not supported")
        }
    }

    package { 'php':
        ensure => latest,
        name   => $package_name
    }
}
