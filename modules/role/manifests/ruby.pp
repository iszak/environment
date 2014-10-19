# == Class: role::ruby
#
# A class to setup ruby server
#
# === Parameters
#
# === Examples
#
#  include role::ruby
#
class role::ruby {
  include role::web

  class { 'rbenv': }
  class { 'rbenv::update': }

  class { 'ruby_build':
    require => Class['rbenv']
  }
  class { 'ruby_build::update': }

  rbenv::config { 'root': }

  rbenv::install { '2.1.3': }
  ->
  class { 'rbenv::global':
    version => '2.1.3'
  }

  apache::module { 'passenger': }
}
