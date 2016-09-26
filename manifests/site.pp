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
