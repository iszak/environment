# == Define: php::ini
#
# A type to install php ini's
#
# === Parameters
#
# [*priority*]
#   The load priority of the ini file
#
# [*php_dir*]
#   The path to the php dir e.g. /etc/php5/cli
#
# [*conf_dir*]
#   The path to the php conf dir e.g. /etc/php5/cli/conf.d
#
# [*settings*]
#   The list of settings
#
#
# === Examples
#
#  php::ini { 'gd':
#    settings => {
#      jpeg_ignore_warning => 1
#    }
#  }
#
define php::ini (
  $priority  = undef,
  $php_dir   = undef,
  $conf_dir  = undef,
  $settings  = []
) {
  include php::params

  $priority_param = $priority ? {
    undef   => 30,
    default => $priority,
  }

  $php_dir_param = $php_dir ? {
    undef   => "/etc/php5/${::php::params::package_name}",
    default => $php_dir,
  }

  $conf_dir_param = $conf_dir ? {
    undef   => "${php_dir_param}/conf.d",
    default => $conf_dir,
  }


  file { $php_dir_param:
    ensure => directory
  }

  file { $conf_dir_param:
    ensure  => directory,
    require => File[$php_dir_param]
  }

  file { "${conf_dir_param}/${priority_param}-${name}.ini":
    ensure  => present,
    require => File[$conf_dir_param],
    content => template('php/ini.erb')
  }
}
