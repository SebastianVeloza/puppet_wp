class apache {
  #instalar apache
  package { "apache2":
    ensure => installed,
  }

  #correr el apache
  service { "apache2":
    ensure => running,
    enable => true,
  }
  #configurarlo
  file { "/etc/apache2/sites-available/000-default.conf":
    ensure  => file,
    content => template("apache/apache.conf.erb"),
    require => Package["apache2"],
    notify  => Service["apache2"],
  }

  exec { "enable_mod_rewrite":
    command => "/usr/sbin/a2enmod rewrite",
    onlyif  => "/bin/false",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }
}
