# == Define: postgresql::user
#
# A type to create postgresql users
#
# === Parameters
#
# [*username*]
#   The username of the user
#
# [*password*]
#   The password of the user
#
# [*superuser*]
#   Whether to make this user a super user
#
# [*createdb*]
#   Whether to create a database for this user
#
# [*creatrole*]
#   Whether to create a role for this user
#
# [*host*]
#   The host of the server
#
# [*port*]
#   The port of the server
#
# === Examples
#
#  postgresql::user { 'iszak':
#
#  }
#
define postgresql::user (
    $username,
    $password   = undef,
    $superuser  = undef,
    $createdb   = undef,
    $createrole = undef,

    $host       = undef,
    $port       = undef,
) {
  include postgresql::params

  $host_param = $host ? {
    undef   => $::postgresql::params::host,
    default => $host,
  }

  $port_param = $port ? {
    undef   => $::postgresql::params::port,
    default => $port,
  }

  $superuser_param = $superuser ? {
    undef   => $::postgresql::params::user_superuser,
    default => $superuser,
  }

  $createdb_param = $createdb ? {
    undef   => $::postgresql::params::user_createdb,
    default => $createdb,
  }

  $createrole_param = $createrole ? {
    undef   => $::postgresql::params::user_createrole,
    default => $createrole,
  }

}
