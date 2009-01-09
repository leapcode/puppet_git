class git::web::lighttpd::base {
    File['/etc/lighttpd/lighttpd.conf']{
        source => [ "puppet://$server/files/git/web/${fqdn}/lighttpd.conf",
                    "puppet://$server/files/git/web/lighttpd.conf",
                    "puppet://$server/git/web/lighttpd.conf" ],
    }
}
