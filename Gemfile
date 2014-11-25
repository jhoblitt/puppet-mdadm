source 'https://rubygems.org'

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

gem 'rake',                    :require => false
gem 'puppetlabs_spec_helper',  :require => false
gem 'puppet-lint',             :require => false
gem 'puppet-syntax',           :require => false
gem 'rspec-puppet',
  :git => 'https://github.com/rodjek/rspec-puppet.git',
  :ref => '6ac97993fa972a15851a73d55fe3d1c0a85172b5',
  :require => false
# rspec 3 spews warnings with rspec-puppet 1.0.1
gem 'rspec-core', '~> 2.0',    :require => false
# see https://github.com/domcleal/rspec-puppet-augeas/issues/9
# rspec-puppet-augeas requires rspec-puppet < 1
gem 'rspec-puppet-augeas',
  :git => 'https://github.com/jhoblitt/rspec-puppet-augeas.git',
  :ref => '6152e283a65f96188dded35be30f6e0540208594',
  :require => false
gem 'ruby-augeas',             :require => false
gem 'beaker',                  :require => false
gem 'beaker-rspec',            :require => false
gem 'serverspec',              :require => false
gem 'pry',                     :require => false

# vim:ft=ruby
