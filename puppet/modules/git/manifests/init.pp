class git inherits git::params {
    package { 'git':
        ensure => latest
    }
}
