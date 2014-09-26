# == Class: i18n
#
# A class to install internationalization support
#
# === Parameters
#
# === Examples
#
#  class { 'i18n': }
#
class i18n () {
  package { 'language-pack-en':
    ensure => latest
  }
}
