class git::web {
    include git
    package{'gitweb':
        ensure => present,
        require => Package['git'],
    }
}
