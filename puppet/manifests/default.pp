# --- Preinstall Stage ---------------------------------------------------------

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}

class { 'apt_get_update':
  stage => preinstall
}

# --- MySQL --------------------------------------------------------------------

class install_mysql {
  include '::mysql::server'
}
class { 'install_mysql': }



# --- PostgreSQL ---------------------------------------------------------------

class install_postgres {

  class { 'postgresql::server': 
    postgres_password => 'postgres'
  }

  postgresql::server::db { 'database_example':
    user     => 'rails',
    password => postgresql_password('rails', 'rails'),
  }
}
class { 'install_postgres': }

package { 'libpq-dev':
  ensure => installed,
}


# --- SQLite -------------------------------------------------------------------

package { ['sqlite3', 'libsqlite3-dev']:
  ensure => installed;
}


# --- MongoDB -------------------------------------------------------------------
class { 'mongodb':
  init => 'sysv',
}


# --- RMagick system dependencies -------------------------------------------------------------------

package { ['libmagickwand4', 'libmagickwand-dev']:
ensure => installed,
}


# --- RVM ---------------------------------------------------------------

class install-rvm {
  include rvm
  rvm::system_user { vagrant: ; }

  rvm_system_ruby {
    'ruby-1.9.3-p194':
      ensure => 'present',
      default_use => true;
    'ree-1.8.7-2012.02':
      ensure => 'present',
      default_use => false;
    'ruby-2.0.0-p247':
      ensure => 'present',
      default_use => false;
  }

  rvm_gem {
    'ruby-1.9.3-p194/bundler': ensure => latest;
    'ruby-1.9.3-p194/rails': ensure => latest;
    'ruby-1.9.3-p194/rake': ensure => latest;
  }

}

class { 'install-rvm': }



# --- Packages -------------------------------------------------------------------



package { 'libreadline-dev':
  ensure => installed
}

# ExecJS runtime.
package { 'nodejs':
  ensure => installed
}