require 'spec_helper'

describe 'mdadm::config', :type => :class do
  context 'no params' do
    it { should include_class('mdadm::config') }
  end

  context 'options =>' do
    context '{}' do
      let(:params) {{ :options => {}}}

      it { should include_class('mdadm::config') }
    end

    context '{ mailaddr => foo }' do
      let(:params) {{ :options => { 'mailaddr' => 'foo' } }}

      it { should contain_augeas('mdadm.conf mailaddr') }

      describe_augeas 'mdadm.conf mailaddr', :lens => 'mdadm_conf', :target => 'etc/mdadm.conf' do
        it 'should change MAILADDR' do
          should execute.with_change
          aug_get('mailaddr/value').should == 'foo'
          should execute.idempotently
        end
      end
    end

    context 'undef' do
      let(:params) {{ :options => nil }}

      it 'should fail' do
        expect { should }.to raise_error(/is not a Hash/)
      end
    end
  end # options =>

end
