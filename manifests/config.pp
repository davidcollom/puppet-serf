class serf::config {
  File {
    owner  => $::serf::config_owner,
    group  => $::serf::config_group,
    mode   => $::serf::config_file_mode,
    notify => Service['serf'],
  }

  file {
    $::serf::config_dir:
      ensure => directory,
      mode   => $::serf::config_dir_mode;

    $::serf::config_file:
      ensure  => present,
      content => template('serf/config.json.erb');
  }

  class { $::serf::service_config_class:
    notify => Service['serf'],
  }
}
