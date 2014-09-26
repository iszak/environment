# == Define: ufw::deny
#
# A type to deny ufw ports
#
# === Parameters
#
# === Examples
#
#  ufw::deny { 'ssh':
#    service => 'ssh'
#  }
#
define ufw::deny (
  $port     = undef,
  $service  = undef,
  $protocol = undef,
  $from     = undef,
  $to       = undef
) {
  include ufw
  include ufw::params

}
