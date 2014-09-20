# == Define: php::module
#
# A type to install php modules
#
# === Parameters
#
# === Examples
#
#  php::module { 'gd': }
#
define php::module (
  $package_prefix = undef
) {
  include php::params

  $package_prefix_param = $package_prefix ? {
    undef   => $::php::params::package_prefix,
    default => $package_prefix,
  }

  package { "${package_prefix_param}-${name}":
    ensure => latest
  }
}
