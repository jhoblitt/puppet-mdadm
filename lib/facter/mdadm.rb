Facter.add('mdadm') do
  confine :kernel => 'Linux'
  setcode do
    Facter::Util::Resolution.which('mdadm')
  end
end
