# == Class: npm::install
#
# A class to install node modules
#
# === Parameters
#
# [*user*]
#   The user to use when cloning
#
# [*group*]
#   The group to use when cloning
#
# [*path*]
#   The path to run npm install
#
# === Examples
#
#  npm::install { 'name':
#    path => '/home/iszak/environment/'
#  }
#
define npm::install (
  $path,
  $user  = undef,
  $group = undef,
) {
  include npm
  include npm::params

  $user_param = $user ? {
    undef   => $::npm::params::install_user,
    default => $user,
  }

  $group_param = $group ? {
    undef   => $::npm::params::install_group,
    default => $group,
  }

  exec { "npm install ${name}":
    require => Package['npm'],
    command => "${::npm::params::bin_path} install",
    user    => $user_param,
    group   => $group_param,
    cwd     => $path,
    creates => "${path}/node_modules/",
  }
}
