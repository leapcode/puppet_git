class git::daemon::vhosts inherits git::daemon {
    File['/etc/sysconfig/git-daemon']{
        source => [ "puppet:///modules/site-git/sysconfig/${fqdn}/git-daemon.vhosts",
                    "puppet:///modules/site-git/sysconfig/git-daemon.vhosts",
                    "puppet:///modules/git/sysconfig/git-daemon.vhosts" ],
    }
}
