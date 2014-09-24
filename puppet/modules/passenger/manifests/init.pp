# == Class: passenger
#
# A class to install passenger
#
# === Parameters
#
# === Examples
#
#  class { 'passenger': }
#
class passenger () {
  include ruby
  include nginx

  ruby::gem { 'passenger': }
}
