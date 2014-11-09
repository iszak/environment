# == Class: composer::install
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
#   The path to run composer install
#
# === Examples
#
#  composer::install { 'name':
#    path => '/home/iszak/environment/'
#  }
#
define composer::install (
  $path,
  $user  = undef,
  $group = undef,
) {
  include composer
  include composer::params

  $user_param = $user ? {
    undef   => $::composer::params::install_user,
    default => $user,
  }

  $group_param = $group ? {
    undef   => $::composer::params::install_group,
    default => $group,
  }

  exec { "composer install ${name}":
    command => "${path}/composer.phar install",
    user    => $user_param,
    group   => $group_param,
    cwd     => $path,
    creates => "${path}/vendor/composer/",
  }
}
