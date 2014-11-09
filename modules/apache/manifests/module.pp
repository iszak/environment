# == Define: apache::ini
#
# A type to install apache inis
#
# === Parameters
#
# [*module*]
#   The module to load
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
  $module         = undef,
  $package_prefix = undef
) {
  include apache
  include apache::params

  $module_param = $module ? {
    undef   => $name,
    default => $module,
  }

  $package_prefix_param = $package_prefix ? {
    undef   => $::apache::params::package_prefix,
    default => $package_prefix,
  }

  package { "${package_prefix_param}-${module_param}":
    ensure => latest
  }
}
