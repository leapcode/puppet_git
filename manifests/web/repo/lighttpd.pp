define git::web::repo::lighttpd(
    ensure = 'present',
    $gitweb_url,
    $gitweb_config
){
  file{"/etc/lighttpd/gitweb.d/${name}.conf": }
  if $ensure == 'present' {
    include git::web::lighttpd
    File["/etc/lighttpd/gitweb.d/${name}.conf"]{
        content => template("git/web/lighttpd"),
        notify => Service['lighttpd'],
        owner => root, group => 0, mode => 0644;
    }
  } else {
    File["/etc/lighttpd/gitweb.d/${name}.conf"]{
      ensure => $ensure,
    }
  }
  line{"add_include_of_gitwebrepo_${name}":
    ensure => $ensure,
    line => "include \"gitweb.d/${name}.conf\"",
    file => "/etc/lighttpd/lighttpd-gitweb.conf",
    require => File['/etc/lighttpd/lighttpd-gitweb.conf'],
    notify => Service['lighttpd'],
  }
}
