# == Class: apache::params
#
# A class to set the default parameters of apache
#
# === Examples
#
#  class { 'apache::params': }
#
class apache::params {
  $package_name   = 'apache2'
  $package_prefix = 'libapache2-mod'

  $owner           = 'root'
  $group           = 'root'

  $sites_enabled   = '/etc/apache2/sites-enabled/'
  $sites_available = '/etc/apache2/sites-available/'

  $host            = ''
  $port            = 80
}
