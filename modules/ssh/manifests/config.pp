# == Define: ssh::config
#
# A type to install configure ssh
#
# === Parameters
#
# === Examples
#
#  ssh::config { 'github':
#    identity_file => '~/.ssh/github.key'
#  }
#
define ssh::config (
  $user          = undef,
  $group         = undef,
  $path          = undef,

  $host          = undef,
  $identity_file = undef
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
    undef   => "/home/${user_param}/.ssh/config",
    default => $path,
  }



  $host_param = $host ? {
    undef   => $::ssh::params::host,
    default => $host,
  }

  $identity_file_param = $identity_file ? {
    undef   => $::ssh::params::identity_file,
    default => $identity_file,
  }


  if (defined(File[$path_param]) == false) {
    file { $path_param:
      ensure => present
    }
  }

  $content = template('ssh/config.erb')

  exec { "config ${name}":
    require => File[$path_param],
    command => "/bin/echo '${content}' >> ${path_param}",
    user    => $user_param,
    group   => $group_param,
    unless  => "/bin/grep '${host_param}' ${path_param}"
  }
}
