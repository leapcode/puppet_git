class git::daemon {

  include git

  case $operatingsystem {
    centos: { include git::daemon::centos }
  }

  if $use_shorewall {
    include shorewall::rules::gitdaemon
  }

  if $use_nagios {
    nagios::service { "git-daemon": check_command => "check_git!${fqdn}"; }
  }
}
