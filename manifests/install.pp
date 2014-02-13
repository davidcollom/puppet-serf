class serf::install{

  # mitchellh refers to anything 64bit as amd64
  case $::architecture {
    x86_64: {
      $_architecture = 'amd64'
    }
    default: {
      $_architecture = $::architecture
    }
  }

  if $::serf::install_method == 'url' {
    Exec{
      path    =>  '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      unless  =>  ["test -e ${::serf::install_path}serf && test `serf -v | grep -c 'Serf v${serf::version}'` -ne 0 "]
    }
    if ! defined(Package['unzip']) {
      package{'unzip':
        ensure=>present
      }->Exec['unzip_serf']
    }
    case $::osfamily {
      'Debian', 'RedHat': {
        $install_url = "https://dl.bintray.com/mitchellh/serf/${::serf::version}_linux_${_architecture}.zip"
      }
      default: {
        fail "Operating system ${::operatingsystem} is not supported yet."
      }
    }
    exec{
      'download_serf':
        command => "wget ${install_url} -c -O /tmp/serf_${::serf::version}.zip";
      'unzip_serf':
        command =>  "unzip -o /tmp/serf_${::serf::version}.zip -d /tmp/serf_${::serf::version}/";
      'install_serf':
        command =>  "mv /tmp/serf_${::serf::version}/serf ${::serf::install_path}/serf && rm -rf /tmp/serf_${::serf::version}*}"
    }
    Exec['download_serf'] ->
    Exec['unzip_serf']    ->
    Exec['install_serf']
  } elsif $::serf::install_method == 'package' {
    package { $::serf::package_name:
      ensure => $::serf::package_ensure
    }
  } else {
    fail("The provided install method ${::serf::install_method} is invalid")
  }

}
