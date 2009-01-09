class git::web::lighttpd inherits lighttpd {
    include git::web::lighttpd::base

    file{'/etc/lighttpd/lighttpd-gitweb-defaults.conf':
        source => [ "puppet://$server/files/git/web/${fqdn}/lighttpd-gitweb-defaults.conf",
                    "puppet://$server/files/git/web/lighttpd-gitweb-defaults.conf",
                    "puppet://$server/git/web/lighttpd-gitweb-defaults.conf" ],
        require => Package['lighttpd'],
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }


    file{'/etc/lighttpd/lighttpd-gitweb.conf':
        ensure => present,
        require => Package['lighttpd'],
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }

    file{'/etc/lighttpd/gitweb.d':
        ensure => directory,
        require => Package['lighttpd'],
        owner => root, group => 0, mode => 0755;
    }
}
