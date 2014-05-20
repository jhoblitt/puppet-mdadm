require 'spec_helper'

describe 'mdadmversion', :type => :fact do
  before(:each) { Facter.clear }

  context 'el5.x versions' do
    context 'mdadm fact => /sbin/madam' do
      it 'should get the version string' do
        Facter.fact(:mdadm).stubs(:value).returns('/sbin/mdadm')
        Facter::Util::Resolution.stubs(:exec).with('/sbin/mdadm --version 2>&1').returns('mdadm - v2.6.9 - 10th March 2009')

        Facter.fact(:mdadmversion).value.should == '2.6.9'
      end
    end
  end # el5.x versions

  context 'el6.x versions' do
    context 'mdadm fact => /sbin/madam' do
      it 'should get the version string' do
        Facter.fact(:mdadm).stubs(:value).returns('/sbin/mdadm')
        Facter::Util::Resolution.stubs(:exec).with('/sbin/mdadm --version 2>&1').returns('mdadm - v3.2.3 - 23rd December 2011')

        Facter.fact(:mdadmversion).value.should == '3.2.3'
      end
    end

    context 'mdadm fact => /sbin/madam' do
      it 'should get the version string' do
        Facter.fact(:mdadm).stubs(:value).returns('/sbin/mdadm')
        Facter::Util::Resolution.stubs(:exec).with('/sbin/mdadm --version 2>&1').returns('mdadm - v3.2.6 - 25th October 2012')

        Facter.fact(:mdadmversion).value.should == '3.2.6'
      end
    end
  end # el6.x versions

  context 'mdadm fact not set' do
    it 'should return nil' do
      Facter.fact(:mdadm).stubs(:value).returns(nil)
      Facter.fact(:mdadmversion).value.should be_nil
    end
  end
end
