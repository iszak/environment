# == Define: zsh::config
#
# A class to configure zsh
#
# === Examples
#
#  zsh::config { "iszak": }
#
define zsh::config (
  $owner = $title,
  $group = $title,
  $path = "/home/${title}/.zshrc"
) {
  include zsh

  file { $path:
    ensure  => present,
    content => template('zsh/config.erb'),
    owner   => $owner,
    group   => $group
  }
}
