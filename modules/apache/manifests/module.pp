# == Define: apache::ini
#
# A type to install apache inis
#
# === Parameters
#
# [*priority*]
#   The load priority of the ini file
#
#
# === Examples
#
#  apache::module { 'xsendfile': }
#
define apache::module (
  $package_prefix = undef
) {
  include apache
  include apache::params

  $module = $name

  $package_prefix_param = $package_prefix ? {
    undef   => $::apache::params::package_prefix,
    default => $package_prefix,
  }

  package { "${package_prefix_param}-${module}":
    ensure => latest
  }
}
