# == Define: ufw::rule
#
# A type to define ufw rules
#
# === Parameters
#
# [*type*]
#   The type of rule either allow or deny
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
#
# === Examples
#
#  ufw::rule { 'allow ssh':
#    service => 'ssh',
#    type    => 'allow'
#  }
#
define ufw::rule (
  $type,
  $port     = undef,
  $service  = undef,
  $protocol = undef,
  $from     = undef,
  $to       = undef,
  $bin_path = undef
) {
  include ufw
  include ufw::params

  if ($service != undef) {
    $rule = $service
  } elsif ($port != undef) {
    if ($protocol != undef) {
      $rule = "${port}/${protocol}"
    } else {
      $rule = $port
    }
  }

  if ($to != undef) {
    fail('The parameters "to" is not supported yet')
  }

  if ($from != undef) {
    fail('The parameters "from" is not supported yet')
  }


  $bin_path_param = $bin_path ? {
    undef   => $::ufw::params::bin_path,
    default => $bin_path,
  }


  exec { "ufw allow ${rule}":
    command => "${bin_path_param} allow ${rule}",
    require => Package['ufw']
  }
}
