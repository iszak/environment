# == Class: project::php
#
# A class to setup a php project
#
# === Parameters
#
# [*host*]
#   The host to setup the virtual host under
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
# === Examples
#
#  project::php { 'test' }
#
define project::php (
  $host    = undef,
  $user    = undef,
  $group   = undef,
  $url     = undef,
  $path    = undef,
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

  ->

  apache::vhost { $name:
    document_root => $path,
    host          => $host,
    owner         => $user,
    group         => $group,
  }
}
