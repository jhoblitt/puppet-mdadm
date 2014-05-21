require 'spec_helper'

describe 'mdadm', :type => :class do

  shared_examples 'mdadm' do
    it { should contain_package('mdadm').with_ensure('present') }
    it { should contain_class('mdadm::params') }
    it { should contain_class('mdadm::mdmonitor') }
    it do
      should contain_service('mdmonitor').with({
        :ensure     => 'running',
        :hasrestart => true,
        :hasstatus  => true,
        :enable     => true,
      })
    end
  end

  context 'on osfamily RedHat' do
    let(:facts) do
      {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'Scientific',
        :operatingsystemmajrelease => 6,
        :mdadm_arrays              => '/dev/md0',
      }
    end

    context 'no params' do
      it_behaves_like 'mdadm'
      it do
        should contain_file('/etc/sysconfig/raid-check').
          with_content(/ENABLED="yes"/).
          with_content(/CHECK="check"/). 
          with_content(/NICE="low"/). 
          with_content(/CHECK_DEVS=""/). 
          with_content(/REPAIR_DEVS=""/). 
          with_content(/SKIP_DEVS=""/)
      end
    end # no params

    context 'service_force =>' do
      context 'true' do
        let(:params) {{ :service_force => true }}
        before { facts.delete(:mdadm_arrays) }

        it do
          should contain_service('mdmonitor').with({
            :ensure     => 'running',
            :hasrestart => true,
            :hasstatus  => true,
            :enable     => true,
          })
        end
      end

      context 'false' do
        let(:params) {{ :service_force => false }}
        before { facts.delete(:mdadm_arrays) }

        it do
          should contain_service('mdmonitor').with({
            :ensure     => 'stopped',
            :hasrestart => true,
            :hasstatus  => true,
            :enable     => false,
          })
        end
      end

      context 'foo' do
        let(:params) {{ :service_force => 'foo' }}

        it 'should fail' do
          expect { should }.to raise_error(/is not a boolean/)
        end
      end
    end # service_force

    context 'service_ensure =>' do
      # we need to set service_force => true to disable the automatic service
      # setup based on the existance of the ::mdadm_arrays fact
      context 'running' do
        let(:params) {{ :service_force => true, :service_ensure => 'running' }}

        it do
          should contain_service('mdmonitor').with({
            :ensure     => 'running',
            :hasrestart => true,
            :hasstatus  => true,
            :enable     => true,
          })
        end
      end

      context 'stopped' do
        let(:params) {{:service_force => true,  :service_ensure => 'stopped' }}

        it do
          should contain_service('mdmonitor').with({
            :ensure     => 'stopped',
            :hasrestart => true,
            :hasstatus  => true,
            :enable     => true,
          })
        end
      end

      context 'foo' do
        let(:params) {{ :service_ensure => 'foo' }}

        it 'should fail' do
          expect { should }.to raise_error(/does not match/)
        end
      end
    end # service_ensure

    context 'service_enable =>' do
      # we need to set service_force => true to disable the automatic service
      # setup based on the existance of the ::mdadm_arrays fact
      context 'true' do
        let(:params) {{ :service_force => true, :service_enable => true }}

        it do
          should contain_service('mdmonitor').with({
            :ensure     => 'running',
            :hasrestart => true,
            :hasstatus  => true,
            :enable     => true,
          })
        end
      end

      context 'false' do
        let(:params) {{:service_force => true,  :service_enable => false }}

        it do
          should contain_service('mdmonitor').with({
            :ensure     => 'running',
            :hasrestart => true,
            :hasstatus  => true,
            :enable     => false,
          })
        end
      end

      context 'foo' do
        let(:params) {{ :service_enable => 'foo' }}

        it 'should fail' do
          expect { should }.to raise_error(/is not a boolean/)
        end
      end
    end # service_enable

    context 'raid_check_manage =>' do
      context 'true' do
        let(:params) {{ :raid_check_manage => true }}

        it { should contain_file('/etc/sysconfig/raid-check') }
      end

      context 'false' do
        let(:params) {{ :raid_check_manage => false }}

        it { should_not contain_file('/etc/sysconfig/raid-check') }
      end

      context 'foo' do
        let(:params) {{ :raid_check_manage => 'foo' }}

        it 'should fail' do
          expect { should }.to raise_error(/is not a boolean/)
        end
      end
    end # raid_check_manage

    context 'raid_check_options =>' do
      context '{}' do
        let(:params) {{ :raid_check_options => {} }}

        it_behaves_like 'mdadm'
        it do
          should contain_file('/etc/sysconfig/raid-check').
            with_content(/ENABLED="yes"/).
            with_content(/CHECK="check"/). 
            with_content(/NICE="low"/). 
            with_content(/CHECK_DEVS=""/). 
            with_content(/REPAIR_DEVS=""/). 
            with_content(/SKIP_DEVS=""/)
        end
      end

      context '{ ... }' do
        let(:params) do
          {
            :raid_check_options => {
              'ENABLED'     => 'foo',
              'CHECK'       => 'foo',
              'NICE'        => 'foo',
              'CHECK_DEVS'  => 'foo',
              'REPAIR_DEVS' => 'foo',
              'SKIP_DEVS'   => 'foo',
            },
          }
        end

        it_behaves_like 'mdadm'
        it do
          should contain_file('/etc/sysconfig/raid-check').
            with_content(/ENABLED="foo"/).
            with_content(/CHECK="foo"/). 
            with_content(/NICE="foo"/). 
            with_content(/CHECK_DEVS="foo"/). 
            with_content(/REPAIR_DEVS="foo"/). 
            with_content(/SKIP_DEVS="foo"/)
        end
      end

      context 'some_string' do
        let(:params) {{ :raid_check_options => 'some_string' }}

        it 'should fail' do
          expect { should }.to raise_error(/is not a Hash/)
        end
      end

    end # raid_check_options =>
  end

end
