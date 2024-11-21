class php {
  #instala paquetes necesarios de php
  package { ["php", "php-mysql", "libapache2-mod-php"]:
    ensure => installed,
  }
  
}
