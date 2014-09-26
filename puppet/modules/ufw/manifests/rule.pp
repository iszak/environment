# == Define: ufw::rule
#
# A type to define ufw rules
#
# === Parameters
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
  $to       = undef
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


  exec { "ufw allow ${rule}":
    require => Package['ufw']
  }
}
