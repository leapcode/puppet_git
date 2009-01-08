class git::daemon::vhosts inherits git::daemon {
    File['/etc/sysconfig/git-daemon']{
        source => [ "puppet://$server/files/git/sysconfig/${fqdn}/git-daemon.vhosts",
                    "puppet://$server/files/git/sysconfig/git-daemon.vhosts",
                    "puppet://$server/git/sysconfig/git-daemon.vhosts" ],
    }
}
