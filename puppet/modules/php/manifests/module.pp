# == Define: php::module
#
# A type to install php modules
#
# === Parameters
#
# === Examples
#
#  php::module { 'gd': }
#
define php::module () {
  include php::params
}
