# == Class: apache::params
#
# A class to set the default parameters of apache
#
# === Examples
#
#  class { 'apache::params': }
#
class apache::params {
  $package_name     = 'apache2'
  $package_prefix   = 'libapache2-mod'

  $owner            = 'root'
  $group            = 'root'

  $sites_enabled    = '/etc/apache2/sites-enabled/'
  $sites_available  = '/etc/apache2/sites-available/'

  $priority         = '20'
  $host             = '*'
  $port             = 80

  $directory_index  = [
    'index.html',
    'index.html',
    'index.php'
  ]
  $directory        = []

  $a2mod_bin_path = '/usr/sbin/'
}
