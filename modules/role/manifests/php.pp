# == Class: role::php
#
# A class to setup php
#
# === Parameters
#
# === Examples
#
#  include role::php
#
class role::php {
  class { 'php':
    package_name => 'fpm'
  }

  php::module { 'intl': }
}
