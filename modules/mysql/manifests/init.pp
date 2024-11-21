
class mysql {
  #instalacion de mysql
  package { "mysql-server":
    ensure => installed,
  }
  #iniciamos el mysql
  service { "mysql":
    ensure => running,
    enable => true,
  }

  #creamos la base de datos 
  exec { "create_wordpress_db":
    command => "mysql -e 'CREATE DATABASE wordpress;'",
    unless  => "mysql -e 'SHOW DATABASES;' | grep wordpress",
    require => Package["mysql-server"],
  }

  #creamos el usuario para wordpress
  exec { "create_wordpress_user":
    command => "mysql -e \"CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wp_pass'; GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';\"",
    unless  => "mysql -e 'SELECT User FROM mysql.user;' | grep wp_user",
    require => Exec["create_wordpress_db"],
  }
}
