class serf::config{

  File {
    owner  => $::serf::config_owner,
    group  => $::serf::config_group,
    mode   => $::serf::config_file_mode,
    notify => Service[$::serf::service_name],
  }

  $config_data = {
    role            => $::serf::role,
    node_name       => $::serf::node,
    bind_addr       => $::serf::bind,
    encrypt_key     => $::serf::encrypt,
    log_level       => $::serf::log_level,
    protocol        => ($::serf::protocol + 2 - 2),
    rpc_addr        => $::serf::rpc_addr,
    event_handlers  => $::serf::event_handler,
    start_join      => $::serf::join,
  }

  file {
    $::serf::config_dir:
      ensure  => directory,
      mode    => $::serf::config_dir_mode;
    $::serf::config_file:
      ensure  => present,
      content => sorted_json($config_data);
    'serf_upstart':
      path    =>  '/etc/init/serf.conf',
      content =>  template('serf/upstart.conf.erb')
  }



}
