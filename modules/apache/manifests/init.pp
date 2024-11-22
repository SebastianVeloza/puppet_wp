class apache {
  package { 'apache2':
    ensure => installed,
  }

  service { 'apache2':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }

  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure  => file,
    content => template('apache/apache.conf.erb'),
    notify  => Service['apache2'],
  }
}
