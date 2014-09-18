# == Class: apt::params
#
# A class to set the default parameters of apt
#
# === Examples
#
#  class { 'apt::params': }
#
class apt::params {
  $update              = 'once'
  $upgrade             = 'once'

  $unattended_upgrades = true
}
