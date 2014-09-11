class rbenv::config (
    $download_path   = $::rbenv::params::download_path,
    $repository_path = $::rbenv::params::repository_path
) inherits ::rbenv::params {
    exec { 'install rbenv':
        require => Package['git'],
        command => "/bin/echo 'export PATH=\"${download_path}/bin:$PATH\"'"
    }
}
