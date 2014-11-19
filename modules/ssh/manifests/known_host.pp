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
  $owner        = undef,
  $group       = undef,
  $path        = undef
) {
  include ssh

  $owner_param = $owner ? {
    undef   => $::ssh::params::owner,
    default => $owner,
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
      owner  => $owner_param,
      group  => $group_param,
      mode   => '0600',
    }
  }

  exec { "ssh known host ${name}":
    require => File[$path_param],
    command => "/bin/echo '${fingerprint}' >> ${path_param}",
    owner   => $owner_param,
    group   => $group_param,
    unless  => "/bin/grep '${fingerprint}' ${path_param}"
  }
}
