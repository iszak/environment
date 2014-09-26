# == Define: ufw::allow
#
# A type to allow ufw ports
#
# === Parameters
#
# === Examples
#
#  ufw::allow { 'ssh':
#    service => 'ssh'
#  }
#
define ufw::allow (
  $port     = undef,
  $service  = undef,
  $protocol = undef,
  $from     = undef,
  $to       = undef
) {
  include ufw
  include ufw::params

}
