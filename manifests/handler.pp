class serf::handler(
  $handler_home   = $::serf::params::handler_home,
)
{

    exec{ 'create handler home':
      path    =>  '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command => "mkdir -p ${serf::handler_home}",
      creates => "${serf::handler_home}",
    }

    file { "${serf::handler_home}/events.log":
      ensure  => present,
      require => Exec['create handler home'],
    }

    file { "${serf::handler_home}/handler.sh":
      ensure  => present,
      content => template('serf/handler.sh.erb'),
      mode    => 0755,
      require => Exec['create handler home'],
    }

}
