class git::daemon::vhosts inherits git::daemon {
    File['/etc/sysconfig/git-daemon']{
        source => [ "puppet://$server/modules/site-git/sysconfig/${fqdn}/git-daemon.vhosts",
                    "puppet://$server/modules/site-git/sysconfig/git-daemon.vhosts",
                    "puppet://$server/modules/git/sysconfig/git-daemon.vhosts" ],
    }
}
