# == Class: rbenv::install
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
#  rbenv::install { '2.1.2': }
#
define rbenv::install (
  $destination = undef,
  $timeout     = undef
) {
  if defined('rbenv') == false {
    fail('rbenv::install requires the rbenv class')
  }

  if defined('ruby_build') == false {
    fail('rbenv::install requires the ruby_build class')
  }

  include rbenv::params

  ruby_build::install { $name:
    destination => $destination,
    timeout     => $timeout
  }
}
