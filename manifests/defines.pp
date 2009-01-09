# domain: the domain under which this repo will be avaiable
# projectroot: where the git repos are listened
# projects_list: which repos to export
define git::web::repo(
    $gitwebconfig,
    $projectroot,
    $projects_list
){
    include git::web
    $gitweb_url = $name
    file{"/etc/gitweb.d/${name}.conf":
        content => template("git/web/config")
    }
    case $gitweb_webserver {
        'lighttpd': {
            git::web::repo::lighttpd{$name:
                gitwebconfig => $gitwebconfig,
                gitweb_url => $gitweb_url,
                projectroot => $projectroot,
                project_list => $projects_list,
            }
        }
        default: { fail("no supported \$gitweb_webserver defined on ${fqdn}, so can't do git::web::repo: ${name}") }
    }

}

define git::web::repo::lighttpd(
    $gitwebconfig,
    $gitweb_url,
    $projectroot,
    $projects_list
){
    include git::web::lighttpd
    file{"/etc/lighttpd/gitweb.d/${name}.conf":
        content => template("git/web/lighttpd"),
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }
    line{"add_include_of_gitwebrepo_${name}":
        line => "Include /etc/lighttpd/gitweb.d/${name}.conf",
        file => "/etc/lighttpd/lighttpd-gitweb.conf",
        require => File['/etc/lighttpd/lighttpd-gitweb.conf'],
        notify => Service['lighttpd'],
    }
}
