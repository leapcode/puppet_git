class git::daemon::debian inherits git::daemon::base {
    
    File { 'git-daemon_initscript':
        path => '/etc/init.d/git-daemon',
    }

    File { 'git-daemon_config':
        path => '/etc/default/git-daemon',
    }

}
