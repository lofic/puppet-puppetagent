Facter.add(:defaultroute) do
    setcode do
        begin
            %x{/sbin/ip route show}[/default via.*/][/\d+\.\d+\.\d+\.\d+/]
        rescue
            nil
        end
    end
end
