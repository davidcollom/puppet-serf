class serf::install{

  Exec{
    path    =>  '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    unless  =>  ["test -e ${::serf::install_path}serf && test `serf -v | grep -c 'Serf v${serf::version}'` -ne 0 "]
  }

  if ! defined(Package['unzip']) {
    package{'unzip':
      ensure=>present
    }->Exec['unzip_serf']
  }

  exec{
    'download_serf':
      command => "wget ${::serf::install_url} -c -O /tmp/serf_${::serf::version}.zip";
    'unzip_serf':
      command =>  "unzip -o /tmp/serf_${::serf::version}.zip -d /tmp/serf_${::serf::version}/";
    'install_serf':
      command =>  "mv /tmp/serf_${::serf::version}/serf ${::serf::install_path}/serf && rm -rf /tmp/serf_${::serf::version}*}"
  }

  Exec['download_serf'] ->
  Exec['unzip_serf']    ->
  Exec['install_serf']

}
