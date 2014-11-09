# == Define: ssh::known_host
#
# A type to install ssh known hosts
#
# === Parameters
#
# === Examples
#
#  ssh::known_host { 'github':
#    fingerprint => 'string'
#  }
#
define ssh::known_host (
  $user        = undef,
  $group       = undef,
  $path        = undef,
  $fingerprint = undef
) {
  include ssh


  $user_param = $user_prefix ? {
    undef   => $::ssh::params::user_prefix,
    default => $user_prefix,
  }

  $group_param = $group_prefix ? {
    undef   => $::ssh::params::group_prefix,
    default => $group_prefix,
  }


  $path_param = $path_prefix ? {
    undef   => $::ssh::params::known_hosts_path,
    default => $path_prefix,
  }

  $fingerprint_param = $fingerprint_prefix ? {
    undef   => $::ssh::params::fingerprint_prefix,
    default => $fingerprint_prefix,
  }

  if (defined(File[$path_param]) == false) {
    file { $path_param:
      ensure => present
    }
  }

  exec { "known host ${name}":
    require => File[$path_param],
    command => "/bin/echo '${fingerprint}' >> ${path_param}",
    user    => $user,
    group   => $group,
    unless  => "/bin/grep '${fingerprint}' ${path_param}"
  }
}
