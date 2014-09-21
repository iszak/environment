# == Class: apache::params
#
# A class to set the default parameters of apache
#
# === Examples
#
#  class { 'apache::params': }
#
class apache::params {
  $package_prefix = 'libapache2-mod'
}
