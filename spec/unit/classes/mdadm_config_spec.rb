require 'spec_helper'

describe 'mdadm', :type => :class do
  let(:facts) do
    {
      :osfamily                  => 'RedHat',
      :operatingsystem           => 'Scientific',
      :operatingsystemmajrelease => 6,
    }
  end

  context 'no params' do
    it { should_not contain_augeas('mdadm.conf mailaddr') }
  end

  # config_file_manage should have no visiable behavior without config_file_options
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

end
