require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.send("disable_80chars")

task :default => [:lint, :syntax]
