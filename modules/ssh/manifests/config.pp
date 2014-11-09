# == Define: ssh::config
#
# A type to install configure ssh
#
# === Parameters
#
# [*owner*]
#   The user to create the config file as
#
# [*group*]
#   The group to create the config file as
#
# [*path*]
#   The path to create the config file
#
# [*host*]
#   The host of the rule
#
# [*hostname*]
#   The hostname for this host
#
# [*port*]
#   The port for this host
#
# [*user*]
#   The user for this host
#
# [*identity_file*]
#   The identity_file for this host
#
#
# [*server_alive_interval*]
#   The server alive interval for this host
#
# [*server_alive_count_max*]
#   The server alive count max for this host
#
# === Examples
#
#  ssh::config { 'github':
#    identity_file => '~/.ssh/github.key'
#  }
#
define ssh::config (
  $owner                  = undef,
  $group                  = undef,
  $path                   = undef,

  $host                   = undef,

  $host_name              = undef,
  $port                   = undef,

  $user                   = undef,
  $identity_file          = undef,

  $server_alive_interval  = undef,
  $server_alive_count_max = undef,
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
    undef   => "/home/${owner_param}/.ssh/config",
    default => $path,
  }



  $host_param = $host ? {
    undef   => $::ssh::params::host,
    default => $host,
  }

  $host_name_param = $host_name ? {
    undef   => undef,
    default => $host_name,
  }

  $port_param = $port ? {
    undef   => undef,
    default => $port,
  }


  $user_param = $user ? {
    undef   => undef,
    default => $user,
  }

  $identity_file_param = $identity_file ? {
    undef   => $::ssh::params::identity_file,
    default => $identity_file,
  }


  $server_alive_interval_param = $server_alive_interval ? {
    undef   => $::ssh::params::server_alive_interval,
    default => $server_alive_interval,
  }

  $server_alive_count_max_param = $server_alive_count_max ? {
    undef   => $::ssh::params::server_alive_count_max,
    default => $server_alive_count_max,
  }


  if (defined(File[$path_param]) == false) {
    file { $path_param:
      ensure => present,
      owner  => $owner_param,
      group  => $group_param,
      mode   => '0600',
    }
  }

  $content = template('ssh/config.erb')

  exec { "config ${name}":
    require => File[$path_param],
    command => "/bin/echo '${content}' >> ${path_param}",
    user    => $owner_param,
    group   => $group_param,
    unless  => "/bin/grep '${host_param}' ${path_param}"
  }
}
