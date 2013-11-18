class serf::params{
  $version          = '0.2.1'
  $protocol         = 1
  $bind             = $::ipaddress
  $config_dir       = '/etc/serf'
  $config_file      = "${config_dir}/serf.conf"
  $log_dir          = '/var/log/serf'
  $encrypt          = ''
  $log_level        = 'info'
  $node             = $::fqdn
  $role             = ''
  $rpc_addr         = "${bind}:7373"
  $install_path     = '/usr/local/bin/'

  $event_handler    = []
  $join             = []

  case $::osfamily {
    'Debian': {
      $install_url    = "https://dl.bintray.com/mitchellh/serf/${version}_linux_${::architecture}.zip"
    }
    default: {
      fail "Operating system ${::operatingsystem} is not supported yet."
    }
  }


  $service_name = 'serf'
  $service_ensure = true
  $service_hasrestart = true
  $service_hasstatus = true

}
