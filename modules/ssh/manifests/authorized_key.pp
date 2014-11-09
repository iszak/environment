# == Define: ssh::authorized_key
#
# A type to install ssh authorized keys
#
# === Parameters
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
  $group       = undef,
  $path        = undef
) {
  include ssh

  $user_param = $user ? {
    undef   => $::ssh::params::user,
    default => $user,
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
      ensure  => present,
      owner   => $user_param,
      group   => $group_param,
    }
  }

  exec { "authorized key ${name}":
    require => File[$path_param],
    command => "/bin/echo '${fingerprint}' >> ${path_param}",
    user    => $user_param,
    group   => $group_param,
    unless  => "/bin/grep '${fingerprint}' ${path_param}"
  }
}
