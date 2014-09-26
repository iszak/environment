# == Class: role::database
#
# A class to setup database server
#
# === Parameters
#
# === Examples
#
#  include role::database
#
class role::database (
  $engine = 'postgresql'
) {

  if ($engine == 'postgresql') {
    class { 'postgresql': }

    ufw::allow { 'postgresql':
      service => 'postgresql'
    }
  } else {
    fail('Database engine not supported')
  }
}
