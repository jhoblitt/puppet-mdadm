require 'spec_helper_acceptance'

describe 'mdadm class' do
  package_name = 'mdadm'
  service_name = 'mdmonitor'

  describe 'running puppet code' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'mdadm': }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp, :catch_failures => true).stderr).to eq("")
      expect(apply_manifest(pp, :catch_changes => true).stderr).to eq("")
    end
  end

  describe package(package_name) do
    it { should be_installed }
  end

  describe service(service_name) do
    it { should be_running }
    it { should be_enabled }
  end
end
