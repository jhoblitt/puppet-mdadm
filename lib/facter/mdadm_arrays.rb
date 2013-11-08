Facter.add('mdadm_arrays') do
  mdadm = Facter.value(:mdadm)

  setcode do
    if mdadm.nil?
      next nil
    end 

    cmd = "#{mdadm} --detail --scan"
    output = Facter::Util::Resolution.exec(cmd)
    if output.nil?
      Facter.debug "#{cmd} returned no output"
      next nil
    end

    # example line:
    # ARRAY /dev/md1 metadata=1.1 name=foo.example.com:1 UUID=cad4da8b:418b3a4b:d27bad88:bb505b62

    md = []
    output.split(/\n/).each do |line|
      Facter.debug "parsing line: #{line}"
      next if line =~ /^\s+/ # white space only (may not be needed)
      device = line.split(/\s+/)[1]
      if device =~ /\S+/
        Facter.debug "found device: #{device}"
        md << device
      end
    end

    if md.length > 0
      next md.sort.join(',')
    else
      next nil
    end
  end
end
