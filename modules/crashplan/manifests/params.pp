# == Class: crashplan::params
#
# A class to set the default parameters of crashplan
#
# === Examples
#
#  class { 'crashplan::params': }
#
class crashplan::params {
  $version       = '3.6.3'
  $download_url  = "http://download.code42.com/installs/linux/install/CrashPlan/CrashPlan_${version}_Linux.tgz"
  $download_path = "/tmp/CrashPlan_${version}_Linux.tgz"
  $extract_path  = '/tmp'
}
