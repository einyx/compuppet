drupal::site { 'example.com':
  core_version => '7.32',
  modules      => {
    'ctools'   => '1.4',
    'token'    => '1.5',
    'pathauto' => '1.2',
    'views'    => '3.8',
  },
  themes       => {
    'omega' => '4.3',
  },
  libraries    => {
    'jquery_ui' => {
      'download' => {
        'type' => 'file',
        'url'  => 'https://github.com/jquery/jquery-ui/archive/1.12.1.zip',
        'md5'  => '2aad2e169e43dc16f6c1b1b33ac370e4',
      },
    },
  },
}
class { 'nginx': }
nginx::resource::vhost { 'example.com':
  www_root => '/drupal',
}

$full_web_path = '/drupal'

nginx::resource::location { "${name}_root":
  ensure          => present,
  vhost           => "example.com",
  www_root        => "${full_web_path}/",
  location        => '~ \.php$',
  index_files     => ['index.php', 'index.html', 'index.htm'],
  proxy           => undef,
  fastcgi         => "unix:/var/run/php5-fpm.sock",
  fastcgi_script  => undef,
  location_cfg_append => {
    fastcgi_connect_timeout => '3m',
    fastcgi_read_timeout    => '3m',
    fastcgi_send_timeout    => '3m'
      }
    }
