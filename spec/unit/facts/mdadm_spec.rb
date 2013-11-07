require 'spec_helper'

describe 'mdadm', :type => :fact do
  before(:each) { Facter.clear }

  context 'kernel => Linux' do
    it 'should find the executable' do
      Facter.fact(:kernel).stubs(:value).returns('Linux')
      Facter::Util::Resolution.stubs(:which).with('mdadm').returns('/sbin/mdadm')

      Facter.fact(:mdadm).value.should == '/sbin/mdadm'
    end
  end
end
