Facter.add(:nameservers) do
        setcode do
            pattern = /^[ \t]*nameserver[\t ]+(\d+\.\d+\.\d+\.\d+)/
            m = File.read('/etc/resolv.conf').scan(pattern).flatten
            (defined? m) ? m.join(',') : nil
        end
end

