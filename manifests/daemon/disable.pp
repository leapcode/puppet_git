class git::daemon::disable {
  Package{'git-daemon':
    ensure => absent,
  }

  File['/etc/init.d/git-daemon']{
    ensure => absent,
  }
  File['/etc/sysconfig/git-daemon']{
    ensure => absent,
  }
  Service['git-daemon']{
    ensure => stopped,
    enable => false,
    require => undef,
    before => File['/etc/init.d/git-daemon'],
  }

  if $use_shorewall {
    include shorewall::rules::gitdaemon::absent
  }
}

