require 'spec_helper'

describe 'mdadm', :type => :class do

  context 'on osfamily RedHat' do
    let(:facts) {{ :osfamily => 'RedHat' }}

    it { should contain_package('mdadm').with_ensure('present') }
    it { should include_class('mdadm::params') }
  end

end
