require 'spec_helper'

describe 'mdadm::config' do
  context 'no params' do
    it { should include_class('mdadm::config') }
  end

  context 'mailaddr =>' do
    context 'undef' do
      let(:params) {{ :mailaddr => nil }}

      it { should include_class('mdadm::config') }
    end

    context 'foo' do
      let(:params) {{ :mailaddr => 'foo' }}

      it { should contain_augeas('mdadm.conf mailaddr') }

      describe_augeas 'mdadm.conf mailaddr', :lens => 'mdadm_conf', :target => 'etc/mdadm.conf' do
        it 'should change MAILADDR' do
          should execute.with_change
          aug_get('mailaddr/value').should == 'foo'
          should execute.idempotently
        end
      end
    end

    context 'true' do
      let(:params) {{ :mailaddr => true }}

      it 'should fail' do
        expect { should }.to raise_error /is not a string/
      end
    end
  end # mailaddr =>

end
