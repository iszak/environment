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
# [*home*]
#   The composer home
#
# [*timeout*]
#   The composer install timeout
#
# === Examples
#
#  composer::install { 'name':
#    path => '/home/iszak/environment/'
#  }
#
define composer::install (
  $path,
  $user    = undef,
  $group   = undef,
  $home    = undef,
  $timeout = undef,
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

  $home_param = $home ? {
    undef   => "/home/${install_user}/",
    default => $home,
  }

  $timeout_param = $timeout ? {
    undef   => $::composer::params::install_timeout,
    default => $timeout,
  }

  exec { "composer install ${name}":
    command     => "${path}/composer.phar install",
    user        => $user_param,
    group       => $group_param,
    cwd         => $path,
    timeout     => $timeout_param,
    environment => ["COMPOSER_HOME=${home_param}"],
    creates     => "${path}/vendor/composer/",
  }
}
