# == Class: ufw::params
#
# A class to set the default parameters of ufw
#
# === Examples
#
#  class { 'ufw::params': }
#
class ufw::params {
  $enable  = true
  $logging = false
}
