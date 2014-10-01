# == Class: postgresql::params
#
# A class to set the default parameters of postgresql
#
# === Examples
#
#  class { 'postgresql::params': }
#
class postgresql::params {
  $package_name    = 'postgresql',

  $host            = 'localhost'
  $port            = 5432

  $user_superuser  = false
  $user_createdb   = false
  $user_createrole = false
}
