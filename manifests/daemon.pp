class git::daemon {
  include git
  package{'git-daemon':
    ensure => installed,
    require => Package['git'],
  }

  xinetd::file{'git':
    require => Package['git-daemon'],
  }
  file{'/etc/init.d/git-daemon':
    require => Package['git-daemon'],
    owner => root, group => 0, mode => 0755;
  }
  file{'/etc/sysconfig/git-daemon':
    require => Package['git-daemon'],
    owner => root, group => 0, mode => 0644;
  }
  service{'git-daemon':
    hasstatus => true,
  }
  if $git_daemon == 'service' {
    Xinetd::File['git']{
      source => "puppet:///modules/git/xinetd.d/git.disabled"
    }
    File['/etc/init.d/git-daemon']{
    source => [ "puppet:///modules/site-git/init.d/${fqdn}/git-daemon",
                "puppet:///modules/site-git/init.d/git-daemon",
                "puppet:///modules/git/init.d/git-daemon" ],
    }
    File['/etc/sysconfig/git-daemon']{
      source => [ "puppet:///modules/site-git/sysconfig/${fqdn}/git-daemon",
                  "puppet:///modules/site-git/sysconfig/git-daemon",
                  "puppet:///modules/git/sysconfig/git-daemon" ],
    }
    Service['git-daemon']{
      ensure => running,
      enable => true,
      require => [ File['/etc/sysconfig/git-daemon'], File['/etc/init.d/git-daemon'] ],
    }
  } else {
    Xinetd::File['git']{
      source => [ "puppet:///modules/site-git/xinetd.d/${fqdn}/git",
                  "puppet:///modules/site-git/xinetd.d/git",
                  "puppet:///modules/git/xinetd.d/git" ],
    }
    Service['git-daemon']{
      ensure => stopped,
      enable => false,
      before => [ File['/etc/sysconfig/git-daemon'], File['/etc/init.d/git-daemon'] ],
    }
    File['/etc/init.d/git-daemon','/etc/sysconfig/git-daemon']{
      ensure => absent,
    }
  }

  if $use_shorewall {
    include shorewall::rules::gitdaemon
  }
}
