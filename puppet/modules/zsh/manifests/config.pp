define zsh::config (
    $owner = $title,
    $group = $title,
    $path = "/home/${title}/.zshrc"
) {
    file { $path:
        ensure  => present,
        content => template('zsh/config.erb'),
        owner   => $owner,
        group   => $group
    }
}
