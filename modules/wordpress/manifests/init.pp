class wordpress {
  package { "wget":
    ensure => installed,
  }

  exec { "download_wordpress":
    command => "wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz && tar -xzvf /tmp/latest.tar.gz -C /var/www/ && mv /var/www/wordpress /var/www/wordpress",
    creates => "/var/www/wordpress",
    path    => ["/usr/bin", "/bin"],
    require => Package["wget"],
  }

  file { "/var/www/wordpress/wp-config.php":
    ensure  => file,
    content => template("wordpress/wp-config.php.erb"),
    require => Exec["download_wordpress"],
  }

  exec { "set_permissions":
  command => "chown -R www-data:www-data /var/www/wordpress",
  path    => ["/usr/bin", "/bin"],
  require => File["/var/www/wordpress/wp-config.php"],
}

}
