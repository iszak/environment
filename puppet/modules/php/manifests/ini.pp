# == Define: php::ini
#
# A type to install php inis
#
# === Parameters
#
# === Examples
#
#  php::ini { 'gd': }
#
define php::lodule () {
  include php::params
}
