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
gem 'rspec-puppet-augeas',     :require => false
gem 'ruby-augeas',             :require => false
# fixing rspec-puppet to < 1.0 due to these issues:
# https://github.com/domcleal/rspec-puppet-augeas/issues/9
# https://github.com/domcleal/rspec-puppet-augeas/issues/14
gem 'rspec-puppet', '< 1.0',   :require => false
gem 'rspec-system',            :require => false
gem 'rspec-system-puppet',     :require => false
gem 'rspec-system-serverspec', :require => false
gem 'serverspec',              :require => false

# vim:ft=ruby
