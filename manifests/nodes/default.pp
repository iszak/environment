node default {
  create_resources(user, hiera('user', {}))
  create_resources(file, hiera('file', {}))

  hiera_include('classes')

  create_resources('ssh::known_host', hiera('ssh::known_host', {}))

  create_resources('zsh::config', hiera('zsh::config', {}))
  create_resources('sudoers::config', hiera('sudoers::config', {}))

  create_resources('php::module', hiera('php::module', {}))
  create_resources('git::clone', hiera('git::clone', {}))
}
