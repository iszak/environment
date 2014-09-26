# == Define: ufw::deny
#
# A type to deny ufw ports
#
# === Parameters
#
# [*port*]
#   The port to allow or deny
#
# [*service*]
#   The service to allow or deny, see /etc/services
#
# [*protocol*]
#   The protocol to allow or deny
#
# [*from*]
#   The source to allow or deny
#
# [*to*]
#   The destination to allow or deny
#
# [*bin_path*]
#   The path to the ufw binary
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
  $to       = undef,
  $bin_path = undef
) {
  include ufw
  include ufw::params

  ufw::rule { "deny ${name}":
    type     => 'deny',
    port     => $port,
    service  => $service,
    protocol => $protocol,
    from     => $from,
    to       => $to
  }
}
