# == Class: crashplan
#
# A class to install crashplan
#
# === Parameters
#
# [*download_url*]
#   The download url of CrashPlan
#
# [*download_path*]
#   The download path of the archive
#
# [*extract_path*]
#   The extract path of the archive
#
# === Examples
#
#  class { 'crashplan': }
#
class crashplan (
  $download_url  = undef,
  $download_path = undef,
  $extract_path  = undef
) {
  include crashplan::params

  $download_url_param = $download_url ? {
    undef   => $::crashplan::params::download_url,
    default => $download_url,
  }

  $download_path_param = $download_path ? {
    undef   => $::crashplan::params::download_path,
    default => $download_path,
  }

  $extract_path_param = $extract_path ? {
    undef   => $::crashplan::params::extract_path,
    default => $extract_path,
  }


  package { 'default-jre-headless':
    ensure => latest
  }

  exec { 'crashplan download':
    command => "/usr/bin/wget ${download_url_param} -O ${download_path_param}",
    creates => $download_path_param
  }

  exec { 'crashplan extract':
    require => Exec['crashplan download'],
    command => "/bin/tar -xzvf ${download_path_param} -C ${extract_path_param}",
    creates => $extract_path_param
  }

  file { 'crashplan express':
    ensure   => present,
    require  => Exec['crashplan extract'],
    path     => "${extract_path_param}/CrashPlan-install/express.sh",
    content  => template('crashplan/express.sh')
  }

  exec { 'crashplan install':
    require => File['crashplan express'],
    command => '/bin/bash express.sh',
    cwd     => "${extract_path_param}/CrashPlan-install/",
    creates => '/usr/local/crashplan'
  }

  service { 'crashplan':
    ensure  => running,
    enable  => true,
    require => Exec['crashplan install'],
  }
}
