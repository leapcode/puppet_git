# manifests/svn.pp

class git::svn {
    include git
    package{'git-svn':
        require => Package['git'],
    }
}
