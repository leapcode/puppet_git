class git::web {
    include git
    package{'gitweb':
        ensure => present,
        require => Package['git'],
    }

    file{'/etc/gitweb.d':
        ensure => directory,
        owner => root, group => 0, mode => 0755;
    }
    file{'/etc/gitweb.conf':
        source => [ "puppet://$server/files/git/web/${fqdn}/gitweb.conf",
                    "puppet://$server/files/git/web/gitweb.conf",
                    "puppet://$server/git/web/gitweb.conf" ],
        require => Package['gitweb'],
        owner => root, group => 0, mode => 0644;
    }
}
