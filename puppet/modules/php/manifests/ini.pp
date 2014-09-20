# == Define: php::ini
#
# A type to install php inis
#
# === Parameters
#
# === Examples
#
#  php::ini { 'gd':
#    jpeg_ignore_warning => 1
#  }
#
define php::ini (

) {
  include php::params
}
