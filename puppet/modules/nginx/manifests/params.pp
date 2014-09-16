# == Class: nginx::params
#
# A class to set the default parameters of nginx
#
# === Examples
#
#  class { 'nginx::params': }
#
class nginx::params {
  $owner           = 'root'
  $group           = 'root'

  $sites_enabled   = '/etc/nginx/sites-enabled/'
  $sites_available = '/etc/nginx/sites-available/'

  $default_site    = false

  $ipv6_only       = true

  $host            = '*'
  $port            = 80

  $index           = ['index.html', 'index.htm']
  $locations       = {
    '/' => {
      try_files => '$uri $uri/ =404'
    },
    '~ /\.ht' => {
      deny => 'all'
    }
  }
  $error_pages = [
    '404 /404.html'
  ]
}
