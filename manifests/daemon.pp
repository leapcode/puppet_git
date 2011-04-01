class git::daemon {

    include git

    case $operatingsystem {
        debian: { include git::daemon::debian }
        centos: { include git::daemon::centos }
    }

    if $use_shorewall {
      include shorewall::rules::gitdaemon
    }

}
