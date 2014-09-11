class ruby_build (
    $download_path   = $::ruby_build::params::download_path,
    $repository_path = $::ruby_build::params::repository_path
) inherits ::ruby_build::params {
    include git

    exec { 'git clone ruby-build':
        require => Package['git'],
        command => "${::git::params::bin_path} clone ${repository_path} ${download_path}",
        creates => $download_path
    }

    exec { 'install ruby-build':
        require => Exec['git clone ruby-build'],
        command => "/bin/sh ${download_path}/install.sh"
    }
}
