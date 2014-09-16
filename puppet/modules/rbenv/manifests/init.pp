# == Class: rbenv
#
# A class to install rbenv
#
# === Parameters
#
# [*download_path*]
#   The path to download rbenv to, default is /tmp/rbenv
#
# [*repository_path*]
#   The url to the repository, default is https://github.com/sstephenson/rbenv.git
#
# === Examples
#
#  class { 'rbenv': }
#
class rbenv (
    $download_path  = $::rbenv::params::download_path,
    $repository_url = $::rbenv::params::repository_url
) inherits ::rbenv::params {
    include git

    exec { 'git clone rbenv':
        require => Package['git'],
        command =>
          "${::git::params::bin_path} clone ${repository_url} ${download_path}",
        creates => $download_path
    }
}
