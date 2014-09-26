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

  if ($from != undef) {
    $from_param = "${type} from ${from}"
  } else {
    $from_param = ''
  }

  if ($to != undef) {
    $to_param = " to ${to}"
  } else {
    $to_param = ''
  }

  $bin_path_param = $bin_path ? {
    undef   => $::ufw::params::bin_path,
    default => $bin_path,
  }


  exec { "ufw allow ${rule_param}":
    command => "${bin_path_param} allow ${rule}",
    require => Package['ufw']
  }
}
