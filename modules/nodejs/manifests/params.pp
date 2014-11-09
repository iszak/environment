# == Class: nodejs::params
#
# A class to set the default parameters of nodejs
#
# === Examples
#
#  class { 'nodejs::params': }
#
class nodejs::params {
  $debug       = false,
  $development = true
}
