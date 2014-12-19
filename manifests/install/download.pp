class serf::install::download {

  # mitchellh refers to anything 64bit as amd64, anything 32bit as 386, and
  # all arm variations as arm.
  $_architecture = $::architecture ? {
    'x86_64' => 'amd64',
    'i386'   => '386',
    'i486'   => '386',
    'armel'  => 'arm',
    'armhf'  => 'arm',
    'armv6l' => 'arm',
    default  => $::architecture,
  }

  # There are probably variations that need to be accounted for
  $_os = downcase($::kernel)

  if ! defined(Package['unzip']) {
    package { 'unzip':
      ensure => present,
      name   => $::serf::unzip_package,
    }
  }

  $url = "https://dl.bintray.com/mitchellh/serf/${::serf::version}_${_os}_${_architecture}.zip"

  exec { 'download_serf':
    command => "wget ${url} -qO - | funzip > ${::serf::install_path}/serf-${::serf::version}",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    creates => "${::serf::install_path}/serf-${::serf::version}",
    before  => File["serf-${::serf::version}"],
  }

  file { "serf-${::serf::version}":
    ensure => present,
    path   => "${::serf::install_path}/serf-${::serf::version}",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { 'serf':
    ensure => "${::serf::install_path}/serf-${::serf::version}",
    path   => "${::serf::install_path}/serf",
  }
}
