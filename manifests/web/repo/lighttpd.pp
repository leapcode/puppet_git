define git::web::repo::lighttpd(
  $ensure = 'present',
  $gitweb_url,
  $gitweb_config
){
  if $ensure == 'present' { include git::web::lighttpd }

  file{"/etc/lighttpd/conf.d/${name}.gitweb.conf": }
  if $ensure == 'present' {
    File["/etc/lighttpd/conf.d/${name}.gitweb.conf"]{
     content => template('git/web/lighttpd'),
     owner => root, group => 0, mode => 0644
    }
  } else {
    File["/etc/lighttpd/conf.d/${name}.gitweb.conf"]{
      ensure => $ensure,
    }
  }
  if defined(Service['lighttpd']) {
    File["/etc/lighttpd/conf.d/${name}.gitweb.conf"]{
      notify => Service['lighttpd'],
    }
  }
}
