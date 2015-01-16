node default {
    hiera_include('classes')

    create_resources(user, hiera_hash('user', {}))
    create_resources(file, hiera_hash('file', {}))
    create_resources(exec, hiera_hash('exec', {}))
    create_resources(service, hiera_hash('service', {}))
    create_resources(package, hiera_hash('package', {}))

    create_resources(apt::ppa, hiera_hash('apt::ppa', {}))
    create_resources(apt::source, hiera_hash('apt::source', {}))

    create_resources(git::config, hiera_hash('git::config', {}))
    create_resources(vcsrepo, hiera_hash('vcsrepo', {}))

    create_resources(apache::mod, hiera_hash('apache::mod', {}))
    create_resources(apache::vhost, hiera_hash('apache::vhost', {}))

    create_resources(postgresql::server::db, hiera_hash('postgresql::server::db', {}))
    create_resources(postgresql::server::role, hiera_hash('postgresql::server::role', {}))

    create_resources(ruby::rake, hiera_hash('ruby::rake', {}))
    create_resources(ruby::bundle, hiera_hash('ruby::bundle', {}))


    create_resources(project::static, hiera_hash('project::static', {}))
    create_resources(project::rails, hiera_hash('project::rails', {}))
    create_resources(project::node, hiera_hash('project::node', {}))
    create_resources(project::ruby, hiera_hash('project::ruby', {}))
    create_resources(project::zf2, hiera_hash('project::zf2', {}))
}
