class serf::install {
  $install_class = $::serf::install_method ? {
    'url'     => '::serf::install::download',
    'package' => '::serf::install::package',
    default   => $::serf::install_method,
  }

  class { $install_class:
    notify => Class['service'],
  }
}
