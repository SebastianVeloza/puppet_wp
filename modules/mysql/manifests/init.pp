class mysql {
  package { "mysql-server":
    ensure => installed,
  }

  service { "mysql":
    ensure => running,
    enable => true,
  }

  exec { "create_wordpress_db":
    command => "mysql -e 'CREATE DATABASE wordpress;'",
    unless  => "mysql -e 'SHOW DATABASES;' | grep wordpress",
    path    => ["/usr/bin", "/bin"],
    require => Package["mysql-server"],
  }

  exec { "create_wordpress_user":
    command => "mysql -e \"CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wp_pass'; GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';\"",
    unless  => "mysql -e 'SELECT User FROM mysql.user;' | grep wp_user",
    path    => ["/usr/bin", "/bin"],
    require => Exec["create_wordpress_db"],
  }
}
