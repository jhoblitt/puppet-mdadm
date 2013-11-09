require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-augeas'

RSpec.configure do |c|
  c.augeas_fixtures = File.expand_path(File.join(__FILE__, '..', 'fixtures', 'augeas'))
end
