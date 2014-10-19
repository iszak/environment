# == Class: project::params
#
# A class to set the default parameters of project
#
# === Examples
#
#  class { 'project::params': }
#
class project::params {
  $user  = 'root'
  $group = 'root'
  $path  = "/home/${user}/"
}
