# == Class: role::nodejs
#
# A class to setup nodejs server
#
# === Parameters
#
# === Examples
#
#  include role::nodejs
#
class role::nodejs {
  class { '::nodejs': }
  class { '::npm': }
}
