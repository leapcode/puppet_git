class git::gitweb {
    include git
    package{'gitweb':
        ensure => present,
        require => Package['git'],
    }
}
