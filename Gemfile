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
gem 'rspec-puppet',            :require => false
# rspec 3 spews warnings with rspec-puppet 1.0.1
gem 'rspec-core', '~> 2.0',    :require => false

# rspec-puppet > 1 appears to breaks rspec-puppet-augeas 0.2.3
# see https://github.com/domcleal/rspec-puppet-augeas/issues/9
# rspec-puppet-augeas requires rspec-puppet < 1
gem 'rspec-puppet-augeas', '0.3.0',    :require => false
gem 'ruby-augeas',             :require => false
gem 'beaker',                  :require => false
gem 'beaker-rspec',            :require => false
gem 'serverspec',              :require => false
gem 'pry',                     :require => false

# vim:ft=ruby
