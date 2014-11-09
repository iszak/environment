node default {
  hiera_include('classes')

  create_resources(user, hiera_hash('user', {}))
  create_resources(file, hiera_hash('file', {}))

  create_resources('ssh::key', hiera_hash('ssh::key', {}))
  create_resources('ssh::known_host', hiera_hash('ssh::known_host', {}))
  create_resources('ssh::authorized_key', hiera_hash('ssh::authorized_key', {}))
  create_resources('ssh::config', hiera_hash('ssh::config', {}))

  create_resources('zsh::config', hiera_hash('zsh::config', {}))
  create_resources('sudoers::config', hiera_hash('sudoers::config', {}))

  create_resources('git::clone', hiera_hash('git::clone', {}))

  create_resources('php::module', hiera_hash('php::module', {}))
  create_resources('apache::vhost', hiera_hash('apache::vhost', {}))
  create_resources('npm::install', hiera_hash('npm::install', {}))
}
