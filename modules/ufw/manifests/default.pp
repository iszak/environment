# == Define: ufw::allow
#
# A type to allow ufw ports
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
#  ufw::default { 'deny incoming':
#    type       => 'deny',
#    connection => 'incoming'
#  }
#
define ufw::default (
  $type,
  $connection,
  $bin_path = undef
) {
  include ufw
  include ufw::params

  $bin_path_param = $bin_path ? {
    undef   => $::ufw::params::bin_path,
    default => $bin_path,
  }


  exec { "ufw default ${type} ${connection}":
    command => "${bin_path_param} ${type} ${connection}",
    require => Package['ufw']
  }
}
