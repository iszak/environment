# == Class: rbenv::install
#
# A class to install a ruby version
#
# === Parameters
#
# [*user*]
#   The user to use when installing ruby
#
# [*group*]
#   The group to use when installing ruby
#
# [*timeout*]
#   The timeout for installing ruby
#
# [*rbenv_root*]
#   The rbenv root for installing ruby
#
# === Examples
#
#  rbenv::install { '2.1.2': }
#
define rbenv::install (
  $user       = undef,
  $group      = undef,
  $timeout    = undef,
  $rbenv_root = undef
) {
  $version = $name

  include ruby_build

  include rbenv
  include rbenv::params

  $user_param = $user ? {
    undef   => $::rbenv::params::install_user,
    default => $user,
  }

  $group_param = $group ? {
    undef   => $::rbenv::params::install_group,
    default => $group,
  }

  $timeout_param = $timeout ? {
    undef   => $::rbenv::params::install_timeout,
    default => $timeout,
  }

  $rbenv_root_param = $rbenv_root ? {
    undef   => $::rbenv::params::install_path,
    default => $rbenv_root,
  }

  exec { "${name} install":
    require     => [
        Exec['install ruby_build'],
        Exec['install rbenv']
    ],
    command     => "${::rbenv::params::bin_path} install ${version}",
    timeout     => $timeout_param,
    user        => $user_param,
    group       => $group_param,
    environment => ["RBENV_ROOT=${rbenv_root_param}"],
    creates     => "${::rbenv::params::version_path}/${version}/",
  }
}
