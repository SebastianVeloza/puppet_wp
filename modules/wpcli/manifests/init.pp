# puppet/modules/wpcli/manifests/init.pp
class wpcli {
  exec { 'install wp-cli':
    command => '/usr/bin/curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp',
    unless  => '/usr/local/bin/wp',
  }
}
