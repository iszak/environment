# == Class: memcached
#
# A class to install memcached
#
# === Examples
#
#  class { "memcached": }
#
class memcached () {
  package { 'memcached':
    ensure => latest
  }

  service { 'memcached':
    ensure  => 'running',
    enable  => true,
    require => Package['memcached'],
  }
}
