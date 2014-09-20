# == Class: ruby_build::install
#
# A class to install a ruby version
#
# === Parameters
#
# [*destination*]
#   The destination for installing ruby
#
# [*timeout*]
#   The timeout for installing ruby
#
# === Examples
#
#  ruby_build::install { '2.1.2': }
#
define ruby_build::install (
  $destination = undef,
  $timeout     = undef
) {
  if defined('ruby_build') == false {
    fail('ruby_build::install requires the ruby_build class')
  }

  $version = $name

  include ruby_build::params

  $destination_param = $destination ? {
    undef   => "${::ruby_build::params::destination_path}/${version}",
    default => $destination,
  }

  $timeout_param = $timeout ? {
    undef   => $::ruby_build::params::install_timeout,
    default => $timeout,
  }

  exec { "${name} install":
    command => "${::ruby_build::params::install_path}/bin/ruby-build ${version} ${destination_param}",
    timeout => $timeout_param,
    creates => $destination_param
  }
}
