class serf::params{
  $version          = '0.3.0'
  $protocol_version = 1
  $bind             = $::ipaddress
  $config_dir       = '/etc/serf'
  $config_file      = "${config_dir}/serf.conf"
  $log_dir          = '/var/log/serf'
  $encrypt          = ''
  $log_level        = 'info'
  $log_file         = '/var/log/serf.log'
  $node             = $::fqdn
  $protocol         = $::serf::params::protocol
  $role             = $::serf::params::role
  $rpc_addr         = "${bind}:7373"
  $install_path     = '/usr/local/bin/'
  $install_method   = 'url'
  $package_name     = 'serf'
  $package_ensure   = 'present'

  $event_handler    = [
    '/usr/bin/echo',
    '/usr/bin/bob'
  ]
  $join             = [
    '127.0.0.1',
    '10.6.20.184',
    '10.5.2.101'
  ]

  $service_name = 'serf'
  $service_ensure = true
  $service_hasrestart = true
  $service_hasstatus = true

}
