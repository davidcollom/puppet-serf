class serf::service{

  service { $::serf::service_name:
    ensure     => $::serf::service_ensure,
    enable     => $::serf::service_enable,
    restart    => "/sbin/initctl restart ${::serf::service_name}",
    start      => "/sbin/initctl start ${::serf::service_name}",
    stop       => "/sbin/initctl stop ${::serf::service_name}",
    status     => "/sbin/initctl status ${::serf::service_name} | grep running",
  }
}
