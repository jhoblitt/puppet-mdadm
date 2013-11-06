require 'spec_helper'

describe 'mdadm', :type => :class do

  describe 'for osfamily RedHat' do
    it { should contain_class('mdadm') }
  end

end
