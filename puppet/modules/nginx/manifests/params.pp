class nginx::params {
    $owner = 'root'
    $group = 'root'

    $sites_enabled   = '/etc/nginx/sites-enabled/'
    $sites_available = '/etc/nginx/sites-available/'

    $default_site    = true

    $ipv6_only       = true

    $host            = '*'
    $port            = 80

    $index           = ['index.html', 'index.htm']
}
