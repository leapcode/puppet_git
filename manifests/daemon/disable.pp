class git::daemon::disable inherits git::daemon {
  Package['git-daemon']{
    ensure => absent,
  }

  Xinetd::File['git']{
    source => "puppet:///modules/git/xinetd.d/git.disabled"
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

