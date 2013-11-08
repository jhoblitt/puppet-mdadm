require 'spec_helper'

describe 'mdadm_arrays', :type => :fact do
  before(:each) { Facter.clear }

  context 'mdadm fact => /sbin/madam' do
    context 'with no configured arrays' do
      it 'should not find any' do
        Facter.fact(:mdadm).stubs(:value).returns('/sbin/mdadm')
        Facter::Util::Resolution.stubs(:exec).
          with('/sbin/mdadm --detail --scan').
          returns(nil)

        Facter.fact(:mdadm_arrays).value.should be_nil
      end
    end

    context 'with 1 configured arrays' do
      it 'it should find 1 arrays' do
        Facter.fact(:mdadm).stubs(:value).returns('/sbin/mdadm')
        Facter::Util::Resolution.stubs(:exec).
          with('/sbin/mdadm --detail --scan').
          returns(<<-EOS)
ARRAY /dev/md0 level=raid0 num-devices=3 metadata=0.90 UUID=cb1e8086:6eb7c4e7:f52f8e1e:d6fa8eb0
          EOS

        Facter.fact(:mdadm_arrays).value.should == '/dev/md0'
      end

      it 'it should find 1 arrays' do
        Facter.fact(:mdadm).stubs(:value).returns('/sbin/mdadm')
        Facter::Util::Resolution.stubs(:exec).
          with('/sbin/mdadm --detail --scan').
          returns(<<-EOS)
ARRAY /dev/md/leo:0 metadata=1.2 name=leo:0 UUID=72b559cc:ba31aa68:c6f50cd8:a7911136
          EOS

        Facter.fact(:mdadm_arrays).value.should == '/dev/md/leo:0'
      end
    end

    context 'with 2 configured arrays' do
      it 'it should find 2 arrays' do
        Facter.fact(:mdadm).stubs(:value).returns('/sbin/mdadm')
        Facter::Util::Resolution.stubs(:exec).
          with('/sbin/mdadm --detail --scan').
          returns(<<-EOS)
ARRAY /dev/md1 metadata=1.1 name=foo.example.com:1 UUID=cad4da8b:418b3a4b:d27bad88:bb505b62
ARRAY /dev/md0 metadata=1.0 name=foo.example.com:0 UUID=1b72731b:92ffd70c:17a0e77a:1551624a
          EOS

        Facter.fact(:mdadm_arrays).value.should == '/dev/md0,/dev/md1'
      end
    end
  end

  context 'mdadm fact not set' do
    it 'should return nil' do
      Facter.fact(:mdadm).stubs(:value).returns(nil)
      Facter.fact(:mdadm_arrays).value.should be_nil
    end
  end
end
