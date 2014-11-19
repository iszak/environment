# == Define: ssh::authorized_key
#
# A type to install ssh authorized keys
#
# === Parameters
#
# [*fingerprint*]
#   The fingerprint of the authorized key
#
# [*user*]
#   The user to create the authorized key file as
#
# [*group*]
#   The group to create the authorized key file as
#
# [*path*]
#   The path to create the authorized key file
#
# === Examples
#
#  ssh::authorized_key { 'github':
#    fingerprint => 'string'
#  }
#
define ssh::authorized_key (
  $fingerprint,
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
    undef   => "/home/${user_param}/.ssh/authorized_keys",
    default => $path,
  }


  if (defined(File[$path_param]) == false) {
    file { $path_param:
      ensure => present,
      owner  => $owner_param,
      group  => $group_param,
      mode   => '0600',
    }
  }

  exec { "ssh authorized key ${name}":
    require => File[$path_param],
    command => "/bin/echo '${fingerprint}' >> ${path_param}",
    user    => $user_param,
    group   => $group_param,
    unless  => "/bin/grep '${fingerprint}' ${path_param}"
  }
}
