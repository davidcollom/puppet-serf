# Class: serf
#
# This module manages serf
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class serf (
  $version        = $::serf::params::version,
  $bind           = $::serf::params::bind,
  $advertise      = $::serf::params::advertise,
  $config_file    = $::serf::params::config_file,
  $config_dir     = $::serf::params::config_dir,
  $encrypt        = $::serf::params::encrypt,

  $event_handler  = $::serf::params::event_handler,
  $join           = $::serf::params::join,

  $log_level      = $::serf::params::log_level,
  $log_file       = $::serf::params::log_file,
  $node           = $::serf::params::node,
  $protocol       = $::serf::params::protocol,
  $role           = $::serf::params::role,
  $rpc_addr       = $::serf::params::rpc_addr,
  $install_url    = $::serf::params::install_url,
  $install_method = $::serf::params::install_method,
  $package_name   = $::serf::params::package_name,
  $package_ensure = $::serf::params::package_ensure,
  $config_owner   = $::serf::params::config_owner,
  $config_group   = $::serf::params::config_group
) inherits serf::params
{

  include install
  include config
  include service

  Class['install'] ->
  Class['config'] ~>
  Class['service']
}
