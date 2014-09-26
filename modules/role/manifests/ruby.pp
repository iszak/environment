# == Class: role::ruby
#
# A class to setup ruby
#
# === Parameters
#
# === Examples
#
#  include role::ruby
#
class role::ruby {
  class { 'ruby': }
  ruby::gem { 'bundler': }

  class { 'rbenv': }
  class { 'rbenv::update': }

  rbenv::install { '2.1.2': }

  class { 'ruby_build': }
  class { 'ruby_build::update': }

  class { 'apache': }

  apache::module { 'passenger': }
}
