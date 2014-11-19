# == Define: ssh::key
#
# A type to install ssh keys
#
# === Parameters
#
# === Examples
#
#  ssh::key { 'github':
#    fingerprint => 'string'
#  }
#
define ssh::key (
  $private_key,
  $public_key,
  $user        = undef,
  $owner       = undef,
  $group       = undef,
  $path        = undef
) {
  include ssh

  $user_param = $user ? {
    undef   => $::ssh::params::user,
    default => $user,
  }

  $owner_param = $owner ? {
    undef   => $::ssh::params::owner,
    default => $owner,
  }

  $group_param = $group ? {
    undef   => $::ssh::params::group,
    default => $group,
  }

  $path_param = $path ? {
    undef   => "/home/${user_param}/.ssh/${name}",
    default => $path,
  }


  file { "${path_param}.key":
    content => $private_key,
    owner   => $owner_param,
    group   => $group_param,
    mode    => '0600',
  }

  file { "${path_param}.pub":
    content => $public_key,
    owner   => $owner_param,
    group   => $group_param,
    mode    => '0600',
  }
}
