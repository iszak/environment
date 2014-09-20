# == Class: rbenv::config
#
# A class to configure rbenv
#
# === Parameters
#
# [*bash*]
#   Install rbenv to bash
#
# [*zsh*]
#   Install rbenv to ZSH
#
# === Examples
#
#  rbenv::config { 'iszak' }
#
define rbenv::config (
  $bash = true,
  $zsh  = false
) {
  include rbenv
  include rbenv::params

  # Bash
  if $bash == true {
    $bash_file = "/home/${name}/.bashrc"

    file { "${name} .bashrc":
      ensure => present,
      path   => $bash_file,
    }

    exec { "${name} rbenv root":
      command => "/bin/echo 'export RBENV_ROOT=${::rbenv::params::install_path}' >> ${bash_file}",
      require => File["${name} .bashrc"],
      unless  => "/bin/grep -P 'RBENV_ROOT=' ${bash_file}"
    }

    exec { "${name} path":
      command => "/bin/echo 'export PATH=\"\$RBENV_ROOT/bin:\$PATH\"' >> ${bash_file}",
      require => [
        Exec["${name} rbenv root"],
        File["${name} .bashrc"],
      ],
      unless  => "/bin/grep -P 'RBENV_ROOT/bin' ${bash_file}"
    }
  }

  # ZSH
  if $zsh == true {
    $zsh_file = "/home/${name}/.zshrc"

    file { "${name} .zshrc":
      ensure => present,
      path   => $zsh_file,
    }

    exec { "${name} rbenv root":
      command => "/bin/echo 'export RBENV_ROOT=${::rbenv::params::install_path}' >> ${zsh_file}",
      require => File["${name} .zshrc"],
      unless  => "/bin/grep -P 'RBENV_ROOT=' ${zsh_file}"
    }

    exec { "${name} path":
      command => "/bin/echo 'export PATH=\"\$RBENV_ROOT/bin:\$PATH\"' >> ${zsh_file}",
      require => [
        Exec["${name} rbenv root"],
        File["${name} .zshrc"],
      ],
      unless  => "/bin/grep -P 'RBENV_ROOT/bin' ${zsh_file}"
    }
  }
}
