define git::web::repo::lighttpd(
    $gitweb_url,
    $gitweb_config
){
    include git::web::lighttpd
    file{"/etc/lighttpd/gitweb.d/${name}.conf":
        content => template("git/web/lighttpd"),
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }
    line{"add_include_of_gitwebrepo_${name}":
        line => "include \"gitweb.d/${name}.conf\"",
        file => "/etc/lighttpd/lighttpd-gitweb.conf",
        require => File['/etc/lighttpd/lighttpd-gitweb.conf'],
        notify => Service['lighttpd'],
    }
}
