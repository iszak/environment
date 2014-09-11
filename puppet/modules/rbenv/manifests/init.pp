class rbenv (
    $download_path   = $::rbenv::params::download_path,
    $repository_path = $::rbenv::params::repository_path
) inherits ::rbenv::params {
    include git

    exec { 'git clone rbenv':
        require => Package['git'],
        command => "${::git::params::bin_path} clone ${repository_path} ${download_path}",
        creates => $download_path
    }
}
