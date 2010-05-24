class git::web::lighttpd {
    include ::lighttpd 

    file{'/etc/lighttpd/conf.d/lighttpd-gitweb.conf':
        content => 'global { server.modules += ("mod_rewrite", "mod_redirect", "mod_alias", "mod_setenv", "mod_cgi" ) }',
        require => Package['lighttpd'],
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }
}
