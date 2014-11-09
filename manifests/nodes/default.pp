node default {
  $users = hiera('user', {})
  $files = hiera('file', {})

  create_resources(user, $users)
  create_resources(file, $files)

  hiera_include('classes')

  create_resources('ssh::known_host', hiera('ssh::known_host', {}))
  create_resources('ssh::authorized_key', hiera('ssh::authorized_key', {}))

  create_resources('zsh::config', hiera('zsh::config', {}))
  create_resources('sudoers::config', hiera('sudoers::config', {}))

  create_resources('php::module', hiera('php::module', {}))
  create_resources('git::clone', hiera('git::clone', {}))
}
