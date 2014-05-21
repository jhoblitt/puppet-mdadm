require 'spec_helper'

describe 'mdadm::params', :type => :class do
  context 'for osfamily RedHat' do
    let(:facts) do
      {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'Scientific',
      }
    end

    context '6.x' do
      before { facts[:operatingsystemmajrelease] = 6 }

      it { should contain_class('mdadm::params') }
    end

    context '5.x' do
      before { facts[:operatingsystemmajrelease] = 5 }

      it { should contain_class('mdadm::params') }
    end

    context '4.x' do
      before { facts[:operatingsystemmajrelease] = 4 }

      it 'should fail' do
        expect { should contain_class('mdadm::params') }.
          to raise_error(Puppet::Error, /not supported on Scientific 4/)
      end
    end
  end # for osmfaily RedHat

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
