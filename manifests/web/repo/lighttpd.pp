define git::web::repo::lighttpd(
  $ensure = 'present',
  $gitweb_url,
  $gitweb_config
){
  if $ensure == 'present' { include git::web::lighttpd }

  lighttpd::vhost::file{$name:
     ensure => $ensure,
     content => template('git/web/lighttpd');
  }
}
