# == Class: git::repository
#
# A class to clone repositories
#
# === Parameters
#
# [*user*]
#   The user to use when cloning
#
# [*group*]
#   The group to use when cloning
#
# [*url*]
#   The url to the repository to clone
#
# [*path*]
#   The path to the repository to clone
#
# === Examples
#
#  git::clone { 'name':
#    url  => 'https://github.com/iszak/environment.git',
#    path => '/home/iszak/environment/'
#  }
#
define git::clone (
  $user  = undef,
  $group = undef,
  $url   = undef,
  $path  = undef,
  $depth = undef,
) {
  include git
  include git::params

  $user_param = $user ? {
    undef   => $::git::params::clone_user,
    default => $user,
  }

  $group_param = $group ? {
    undef   => $::git::params::clone_group,
    default => $group,
  }

  $depth_param = $depth ? {
    undef   => $::git::params::clone_depth,
    default => $depth,
  }

  exec { "git clone ${name}":
    require => Package['git'],
    command => "${::git::params::bin_path} clone --depth=${depth_param} ${url} ${path}",
    user    => $user_param,
    group   => $group_param,
    creates => $path
  }
}
