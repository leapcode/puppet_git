class git::web::lighttpd {
    include lighttpd 
    include lighttpd::base::git::web

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
class lighttpd::base::git::web inherits lighttpd::base {
    File['/etc/lighttpd/lighttpd.conf']{
        source => [ "puppet://$server/files/git/web/${fqdn}/lighttpd.conf",
                    "puppet://$server/files/git/web/lighttpd.conf",
                    "puppet://$server/git/web/lighttpd.conf" ],
    }
}
