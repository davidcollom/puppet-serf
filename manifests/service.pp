class serf::service {
  service { 'serf':
    ensure => running,
    enable => true,
  }
}
