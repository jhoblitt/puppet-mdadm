require 'spec_helper'

describe 'mdadm::params', :type => :class do
  describe 'for osfamily RedHat' do
    let :facts do
      {
        :osfamily => 'RedHat',
      }
    end

    it { should contain_class('mdadm::params') }
  end

  describe 'unsupported osfamily' do
    let :facts do 
      {
        :osfamily        => 'Debian',
        :operatingsystem => 'Debian',
      }
    end
  
    it 'should fail' do
      expect { should contain_class('mdadm::params') }.
        to raise_error(Puppet::Error, /not supported on Debian/)
    end
  end

end
