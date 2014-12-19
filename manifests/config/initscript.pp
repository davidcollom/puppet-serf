class serf::config::initscript {
  # On Debian, create an initscript
  file { '/etc/init.d/serf':
    owner   => $::serf::config_owner,
    group   => $::serf::config_group,
    mode    => '0755',
    notify  => Service['serf'],
    content => template('serf/initscript.erb'),
  }
}
