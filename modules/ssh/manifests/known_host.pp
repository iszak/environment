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
    undef   => $::ssh::params::known_hosts_path,
    default => $path,
  }


  if (defined(File[$path_param]) == false) {
    file { $path_param:
      ensure => present,
      owner  => $user_param,
      group  => $group_param,
      mode   => '0600',
    }
  }

  exec { "ssh known host ${name}":
    require => File[$path_param],
    command => "/bin/echo '${fingerprint}' >> ${path_param}",
    user    => $user_param,
    group   => $group_param,
    unless  => "/bin/grep '${fingerprint}' ${path_param}"
  }
}
