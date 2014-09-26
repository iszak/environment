# == Class: role::web
#
# A class to setup web
#
# === Parameters
#
# === Examples
#
#  include role::web
#
class role::web {
  class { 'apache': }

  apache::module { 'bw': }
  apache::module { 'security2': }
  apache::module { 'xsendfile': }
}
