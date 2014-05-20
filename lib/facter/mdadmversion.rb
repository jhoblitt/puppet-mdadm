Facter.add('mdadmversion') do
  mdadm = Facter.value(:mdadm)
  setcode do
    unless mdadm.nil?
      # `mdadm --version` sends it's output to stderr
      output = Facter::Util::Resolution.exec("#{mdadm} --version 2>&1")
      next if output.nil?
      m = output.match(/mdadm - v([\d\.]+) -/)
      next unless m.size == 2
      m[1]
    end 
  end
end
