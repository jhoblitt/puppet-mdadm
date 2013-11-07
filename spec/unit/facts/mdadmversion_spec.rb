require 'spec_helper'

describe 'mdadmversion', :type => :fact do
  before(:each) { Facter.clear }

  context 'mdadm fact => /sbin/madam' do
    it 'should get the version string' do
      Facter.fact(:mdadm).stubs(:value).returns('/sbin/mdadm')
      Facter::Util::Resolution.stubs(:exec).with('/sbin/mdadm --version 2>&1').returns('mdadm - v3.2.3 - 23rd December 2011')

      Facter.fact(:mdadmversion).value.should == 'mdadm - v3.2.3 - 23rd December 2011'
    end
  end

  context 'mdadm fact not set' do
    it 'should return nil' do
      Facter.fact(:mdadm).stubs(:value).returns(nil)
      Facter.fact(:mdadmversion).value.should be_nil
    end
  end
end
