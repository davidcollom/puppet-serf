class serf::config::upstart {
  # On Ubuntu, create an upstart config
  file { '/etc/init/serf.conf',
    owner   => $::serf::config_owner,
    group   => $::serf::config_group,
    mode    => $::serf::config_file_mode,
    notify  => Service['serf'],
    content => template('serf/upstart.conf.erb'),
  }
}
