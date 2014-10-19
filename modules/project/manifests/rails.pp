# == Class: project::rails
#
# A class to setup a rails project
#
# === Parameters
#
# [*user*]
#   The user to setup the project under
#
# [*group*]
#   The group to setup the project under
#
# [*url*]
#   The git url to clone the project from
#
# [*path*]
#   The path to clone the project to
#
# [*version*]
#   The ruby version to install
#
# === Examples
#
#  project::rails { 'test' }
#
define project::rails (
  $user    = undef,
  $group   = undef,
  $url     = undef,
  $path    = undef,
  $version = undef,
) {
  include git
  include project::params

  $user_param = $user ? {
    undef   => $::project::params::user,
    default => $user,
  }

  $group_param = $group ? {
    undef   => $::project::params::group,
    default => $group,
  }

  $path_param = $path ? {
    undef   => $::project::params::path,
    default => $path,
  }

  user { $user_param:
    ensure     => present,
    managehome => true,
  }

  git::clone { $name:
    require => User[$user_param],
    url     => $url,
    path    => $path,
  }

  # rbenv::install { '2.1.2':
  #   require => User[$user],
  #   user    => $user,
  #   group   => $group
  # }
}
