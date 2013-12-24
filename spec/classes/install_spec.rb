require 'spec_helper'

describe 'serf::install' do

  context 'with defaults' do
    let(:pre_condition) { 'include serf' }
    it { should contain_exec('download_serf') }
    it { should contain_exec('unzip_serf') }
    it { should contain_exec('install_serf') }
  end

  context 'When specifying a version to use' do
    let(:pre_condition) { 'class { "serf": version => "test_version" }' }

    it { should contain_exec('download_serf').\
      with_command('wget https://dl.bintray.com/mitchellh/serf/test_version_linux_.zip -c -O /tmp/serf_test_version.zip')
    }
    it { should contain_exec('unzip_serf').\
      with_command('unzip -o /tmp/serf_test_version.zip -d /tmp/serf_test_version/')
    }
    it { should contain_exec('install_serf').\
      with_command('mv /tmp/serf_test_version/serf /usr/local/bin//serf && rm -rf /tmp/serf_test_version*}')
    }
  end

  context 'When requesting to install via a package with defaults' do
    let(:pre_condition) { 'class { "serf": install_method => "package" }' }
    it { should contain_package('serf').\
      with(
        :ensure => 'present'
      )
    }
  end

  context 'When requesting to install via a package and special names and ensures' do
    let(:pre_condition) { 'class { "serf": install_method => "package", 
                                           package_ensure => "latest", 
                                           package_name   => "custom_serf" 
                                 }' }
    it { should contain_package('custom_serf').\
      with( :ensure => 'latest' ) }
  end

end
