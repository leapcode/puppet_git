# submodules: Whether we should initialize and update
#             submodules as well
#             Default: false
define git::clone(
  $ensure = present,
  $git_repo,
  $projectroot,
  $submodules = false,
  $cloneddir_user='root',
  $cloneddir_group='0',
  $cloneddir_restrict_mode=true
){
  case $ensure {
    absent: {
      exec{"rm -rf $projectroot":
        onlyif => "test -d  $projectroot",
      }
    }
    default: {
      require ::git
      exec {"git-clone_${name}":
        command => "git clone --no-hardlinks ${git_repo} ${projectroot}",
        creates => "${projectroot}/.git",
        user => root,
        notify => Exec["git-clone-chown_${name}"],
      }
      if $submodules {
        exec{"git-submodules_${name}":
          command => "git submodule init && git submodule update",
          cwd => $projectroot,
          refreshonly => true,
          subscribe => Exec["git-clone_${name}"],
        }
      }
      exec {"git-clone-chown_${name}":
        command => "chown -R ${cloneddir_user}:${cloneddir_group} ${projectroot};chmod -R og-rwx ${projectroot}/.git",
        refreshonly => true
      }
      if $cloneddir_restrict_mode {
        exec {"git-clone-chmod_${name}":
          command => "chmod -R o-rwx ${projectroot}",
          refreshonly => true,
          subscribe => Exec["git-clone_${name}"],
        }
      }
    }
  }
}
