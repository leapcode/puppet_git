class git::daemon::vhosts inherits git::daemon {
  if $git_daemon == 'service' {
    File['/etc/sysconfig/git-daemon']{
      source => [ "puppet:///modules/site-git/sysconfig/${fqdn}/git-daemon.vhosts",
                  "puppet:///modules/site-git/sysconfig/git-daemon.vhosts",
                  "puppet:///modules/git/sysconfig/git-daemon.vhosts" ],
    }
  } else {
    File['/etc/xinetd.d/git']{
      source => [ "puppet:///modules/site-git/xinetd.d/${fqdn}/git.vhosts",
                  "puppet:///modules/site-git/xinetd.d/git.vhosts",
                  "puppet:///modules/git/xinetd.d/git.vhosts" ],
    }
  }
}
