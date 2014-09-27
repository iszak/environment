# == Class: rbenv::install
#
# A class to install a ruby version
#
# === Parameters
#
# [*timeout*]
#   The timeout for installing ruby
#
# === Examples
#
#  rbenv::install { '2.1.2': }
#
define rbenv::install (
  $timeout = undef
) {
  $version = $name

  include ruby_build

  include rbenv
  include rbenv::params

  $timeout_param = $timeout ? {
    undef   => $::rbenv::params::build_timeout,
    default => $timeout,
  }

  exec { "${name} install":
    command => "${::rbenv::params::bin_path} install ${version}",
    timeout => $timeout_param,
    creates => "${::rbenv::params::version_path}/${version}/"
  }
}
