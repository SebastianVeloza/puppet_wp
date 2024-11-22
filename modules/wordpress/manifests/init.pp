class wordpress {
  package { 'curl':
    ensure => installed,
  }
  
  exec { 'check-mysql':
    command => 'mysqladmin ping',
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    unless  => 'mysqladmin ping',
    require => Package['mysql-server'],
  }

  exec { 'download-wp':
    command => '/usr/bin/curl -O https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz && mv wordpress/* /var/www/html',
    cwd     => '/tmp',
    creates => '/var/www/html/wp-config-sample.php',
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => Package['curl'],
  }

  file { '/var/www/html/wp-config.php':
    ensure  => file,
    content => template('wordpress/wp-config.php.erb'),
    require => Exec['download-wp'],
  }

  exec { 'wp-cli-setup':
    command => '/usr/bin/curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp',
    creates => '/usr/local/bin/wp',
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => Package['curl'],
  }

  exec { 'remove-apache-index': 
  command => 'sudo rm /var/www/html/index.html', 
  onlyif => 'test -f /var/www/html/index.html', 
  path => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'], 
  require => Exec['download-wp'], 
  }

  exec { 'install-wp':
    command => "sudo -u www-data /usr/local/bin/wp core install --url='http://localhost:8089' --title='Actividad 1 Sebastian Veloza' --admin_user='admin' --admin_password='admin' --admin_email='admin@example.com' --path='/var/www/html'",
    cwd     => '/var/www/html',
    path    => ['/usr/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => [Exec['wp-cli-setup'], File['/var/www/html/wp-config.php']],
  }
  
}
