# == Class: role::backup
#
# A class to setup backup
#
# === Parameters
#
# === Examples
#
#  include role::backup
#
class role::backup {
  class { 'crashplan': }
}
