class mysql {
  package { ['mysql-server', 'mysql-client']:
    ensure => installed,
  }

  service { 'mysql':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }

  #creacion de base de datos
  exec { 'create-database':
    command => "/usr/bin/mysql -u root -e 'CREATE DATABASE wordpress;'",
    unless  => "/usr/bin/mysql -u root -e 'SHOW DATABASES;' | grep wordpress",
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => Service['mysql'],
  }

  #creacion de usuario
  exec { 'create-mysql-user':
    command => "/usr/bin/mysql -u root -e \"CREATE USER 'wp_bd'@'localhost' IDENTIFIED BY '123admin';\"",
    unless  => "/usr/bin/mysql -u root -e \"SELECT User FROM mysql.user WHERE User = 'wp_bd';\" | grep wp_bd",
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => Service['mysql'],
  }

  #otorgar permisos 
  exec { 'grant-privileges':
    command => "/usr/bin/mysql -u root -e \"GRANT ALL PRIVILEGES ON *.* TO 'wp_bd'@'localhost' WITH GRANT OPTION;\"",
    unless  => "/usr/bin/mysql -u root -e \"SHOW GRANTS FOR 'wp_bd'@'localhost';\" | grep 'GRANT ALL PRIVILEGES'",
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => Exec['create-mysql-user'],
  }
}
