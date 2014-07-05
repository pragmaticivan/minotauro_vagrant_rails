$version = "0.0.1"

# --- Preinstall Stage ---------------------------------------------------------

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

class after::system::update {
  notify {"Start system configuration after system update": }

  $as_vagrant   = 'sudo -u vagrant -H bash -l -c'
  $home         = '/home/vagrant'
  $ruby_version = '2.1.2'

  # --- MySQL -------------------------------------------------------------------
  class { "mysql": }

  # --- PostgreSQL --------------------------------------------------------------
  class { 'postgresql': }

  # --- MongoDB -----------------------------------------------------------------
  include '::mongodb::server'

  # --- Redis -------------------------------------------------------------------
  include redis

  # --- Elasticsearch -----------------------------------------------------------
  class { 'elasticsearch':
    package_url => 'https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb'
  }

  # --- Install terminal helpers ------------------------------------------------
  package {"tree":
    ensure => present,
  }

  # --- Install vim -------------------------------------------------------------
  package {"vim":
    ensure => present,
  }

  # --- Install libreadline-dev  ------------------------------------------------
  package { 'libreadline-dev':
    ensure => installed
  }
  
  # --- Install git -------------------------------------------------------------
  package {["git-core", "git-doc"]:
    ensure => present,
  }

  # --- Install curl -------------------------------------------------------------
  package {["curl"]:
    ensure => present,
  }

  # --- Install nodejs -----------------------------------------------------------
  package { 'nodejs':
    ensure => installed
  }

  # --- RMagick system dependencies ----------------------------------------------
  package { ['libmagickwand4', 'libmagickwand-dev']:
    ensure => installed,
  }

  # --- Install rvm --------------------------------------------------------------
  exec { 'install_rvm':
    command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
    creates => "${home}/.rvm/bin/rvm",
    require => Package['curl']
  }

  exec { 'install_ruby':
    # We run the rvm executable directly because the shell function assumes an
    # interactive environment, in particular to display messages or ask questions.
    # The rvm executable is more suitable for automated installs.
    #
    # use a ruby patch level known to have a binary
    command => "${as_vagrant} '${home}/.rvm/bin/rvm install ruby-${ruby_version} --binary --autolibs=enabled && rvm alias create default ${ruby_version}'",
    creates => "${home}/.rvm/bin/ruby",
    require => Exec['install_rvm']
  }

  # RVM installs a version of bundler, but for edge Rails we want the most recent one.
  exec { "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'":
    creates => "${home}/.rvm/bin/bundle",
    require => Exec['install_ruby']
  }

}

exec { "apt-get update":
  command => "/usr/bin/apt-get update",
  before => Notify["Start system update"],
}
notify { "Start system update": }

class { "after::system::update":
  subscribe => Exec["apt-get update"],
}
