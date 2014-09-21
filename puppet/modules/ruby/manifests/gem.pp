# == Define: ruby::gem
#
# A type to install ruby gems
#
# === Parameters
#
# === Examples
#
#  ruby::gem { 'bundler': }
#
define ruby::gem () {
  package { $name:
    ensure   => installed,
    provider => 'gem',
  }
}
