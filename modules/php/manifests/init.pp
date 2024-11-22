class php {
  package { ['php',  'libapache2-mod-php','php-mysqli']:
    ensure => installed,
  }

 #habilitar php en apache
  exec { 'enable-php':
    command => '/usr/sbin/a2enmod php8.1',
    unless  => '/usr/sbin/a2query -m php8.1 | grep -q "enabled"',
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => Package['libapache2-mod-php'],
  }

  exec { 'install-php-mysql':     
  command => 'sudo apt-get install -y  php-mysqli', 
  unless => 'php -m | grep -q mysqli', 
  path => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'], 
  require => Package['php'], 
  }
}
