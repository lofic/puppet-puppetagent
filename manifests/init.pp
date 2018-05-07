# Puppet agent configuration and facts for the nodes
# in my test and dev environments.

# Update : now I use some DNS SRV records for more flexibility.

class puppetagent(
    Boolean $use_srv_records,
    Optional[String] $puppetmaster = undef,
) {

    service { 'puppet' :
        ensure => running,
        enable => true,
    }

    $pupagentcfgfile = '/etc/puppetlabs/puppet/puppet.conf'


    $srvrecsetting = [ "set main/use_srv_records ${use_srv_records}" ]

    $pmsetting = $puppetmaster ? {
        undef   => [],
        default => [ "set main/server ${puppetmaster}" ],
    }

    augeas { 'Puppet agent config':
        incl    => $pupagentcfgfile,
        lens    => 'puppet.lns',
        changes => concat($srvrecsetting, $pmsetting)
    }

}
