# == Class: ssh::params
#
# A class to set the default parameters of ssh
#
# === Examples
#
#  class { 'ssh::params': }
#
class ssh::params {
  $client           = true
  $client_package   = 'openssh-client'

  $server           = true
  $server_package   = 'openssh-server'


  $user             = 'root'
  $owner            = 'root'
  $group            = 'root'

  $known_hosts_path = '/etc/ssh/ssh_known_hosts'

  $server_alive_count_max = 120
  $server_alive_interval  = 30
}
