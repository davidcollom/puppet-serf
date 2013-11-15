class serf::service{

  service { $::serf::service_name:
    ensure     => $::serf::service_ensure,
    enable     => $::serf::service_enable,
    hasrestart => $::serf::service_hasrestart,
    hasstatus  => $::serf::service_hasstatus,
  }
}
