class serf::install::package {
  package { 'serf':
    ensure => $::serf::version,
    name   => $::serf::package_name,
  }
}
