# == Class: role::php
#
# A class to setup PHP server
#
# === Parameters
#
# === Examples
#
#  include role::php
#
class role::php {
  class { '::php':
    package_name => 'fpm'
  }

  php::module { 'intl': }
}
