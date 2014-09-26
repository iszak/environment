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
  include ruby_build

  include rbenv
  include rbenv::params

  ruby_build::install { $name:
    destination => $destination,
    timeout     => $timeout
  }
}
