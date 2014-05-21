require 'spec_helper'

describe 'mdadm', :type => :class do

  shared_examples 'mdadm' do
    it { should contain_package('mdadm').with_ensure('present') }
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
          with_content(/^ENABLED="yes"/).
          with_content(/^CHECK="check"/). 
          with_content(/^NICE="low"/). 
          with_content(/^CHECK_DEVS=""/). 
          with_content(/^REPAIR_DEVS=""/). 
          with_content(/^SKIP_DEVS=""/).
          with_content(/^MAXCONCURRENT=""/)
      end
      it { should_not contain_augeas('mdadm.conf mailaddr') }
    end # no params

    # config_file_manage should have no visiable behavior without
    # config_file_options
    context 'config_file_manage =>' do
      context 'true' do
        let(:params) {{ :config_file_manage => true }}

        it { should_not contain_augeas('mdadm.conf mailaddr') }
      end

      context 'false' do
        let(:params) {{ :config_file_manage => false }}

        it { should_not contain_augeas('mdadm.conf mailaddr') }
      end

      context 'foo' do
        let(:params) {{ :config_file_manage => 'foo' }}

        it 'should fail' do
          expect { should }.to raise_error(/is not a boolean/)
        end
      end
    end # config_file_manage =>

    context 'config_file_options =>' do
      context '{}' do
        let(:params) {{ :config_file_options => {}}}

        it { should_not contain_augeas('mdadm.conf mailaddr') }
      end

      context '{ mailaddr => foo }' do
        let(:params) {{ :config_file_options => { 'mailaddr' => 'foo' } }}

        it { should contain_augeas('mdadm.conf mailaddr') }

        # mdadm.conf already has a MAILADDR line
        describe_augeas 'mdadm.conf mailaddr', :lens => 'mdadm_conf', :target => 'etc/mdadm.conf' do
          it 'should change MAILADDR' do
            should execute.with_change
            aug_get('mailaddr/value').should == 'foo'
            should execute.idempotently
          end
        end

        # mdadm.conf does not have a MAILADDR line
        describe_augeas 'mdadm.conf mailaddr', :lens => 'mdadm_conf', :target => 'etc/mdadm.conf', :fixture => 'etc/mdadm.conf-no_mailaddr' do
          it 'should change MAILADDR' do
            should execute.with_change
            aug_get('mailaddr/value').should == 'foo'
            should execute.idempotently
          end
        end

        context 'and config_file_manage =>' do
          context 'true' do
            before { params[:config_file_manage] = true }

            it { should contain_augeas('mdadm.conf mailaddr') }
          end

          context 'false' do
            before { params[:config_file_manage] = false }

            it { should_not contain_augeas('mdadm.conf mailaddr') }
          end
        end
      end # { mailaddr => foo }

      context 'undef' do
        let(:params) {{ :config_file_options => nil }}

        it 'should fail' do
          expect { should }.to raise_error(/is not a Hash/)
        end
      end
    end # options =>

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
        context 'on el6.x' do
          before { facts[:operatingsystemmajrelease] = 6 }
          let(:params) {{ :raid_check_options => {} }}

          it_behaves_like 'mdadm'
          it do
            should contain_file('/etc/sysconfig/raid-check').
              with_content(/^ENABLED="yes"/).
              with_content(/^CHECK="check"/).
              with_content(/^NICE="low"/).
              with_content(/^CHECK_DEVS=""/).
              with_content(/^REPAIR_DEVS=""/).
              with_content(/^SKIP_DEVS=""/).
              with_content(/^MAXCONCURRENT=""/)
          end
        end # el6.x

        context 'on el5.x' do
          before { facts[:operatingsystemmajrelease] = 5 }
          let(:params) {{ :raid_check_options => {} }}

          it_behaves_like 'mdadm'
          it do
            should contain_file('/etc/sysconfig/raid-check').
              with_content(/^ENABLED="yes"/).
              with_content(/^CHECK="check"/).
              with_content(/^CHECK_DEVS=""/).
              with_content(/^REPAIR_DEVS=""/).
              with_content(/^SKIP_DEVS=""/)

            should_not contain_file('/etc/sysconfig/raid-check').
              with_content(/^NICE="low"/).
              with_content(/^MAXCONCURRENT=""/)
          end
        end # el5.x
      end # {}

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
            with_content(/^ENABLED="foo"/).
            with_content(/^CHECK="foo"/).
            with_content(/^NICE="foo"/).
            with_content(/^CHECK_DEVS="foo"/).
            with_content(/^REPAIR_DEVS="foo"/).
            with_content(/^SKIP_DEVS="foo"/).
            with_content(/^MAXCONCURRENT=""/)
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
