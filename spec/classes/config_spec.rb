require 'spec_helper'

describe 'serf::config' do

  context 'with defaults' do
    let(:pre_condition) { 'include serf' }
    it { should contain_file('/etc/serf') }
    it { should contain_file('/etc/serf/serf.conf') }
    it { should contain_file('serf_upstart') }
  end

  context 'with custom config_dir' do
    let(:pre_condition) { 'class { "serf": config_dir => "/opt/serf" }' }
    it { should contain_file('/opt/serf').with_ensure('directory') }
    it { should contain_file('/etc/serf/serf.conf') }
  end

  context 'with custom config_file' do
    let(:pre_condition) { 'class { "serf": config_file => "serf_test.conf" }' }
    it { should contain_file('/etc/serf').with_ensure('directory') }
    xit { should contain_file('/etc/serf/serf_test.conf').with_ensure('file') }
  end

  context 'with custom owner' do
    let(:pre_condition) { 'class { "serf": config_owner => "serf" }' }
    it { should contain_file('/etc/serf').with_owner('serf') }
    it { should contain_file('/etc/serf/serf.conf').with_owner('serf') }
  end

  context 'with custom group' do
    let(:pre_condition) { 'class { "serf": config_group => "serf" }' }
    it { should contain_file('/etc/serf').with_group('serf') }
    it { should contain_file('/etc/serf/serf.conf').with_group('serf') }
  end
  context 'with custom group and owner' do
    let(:pre_condition) { 'class { "serf": config_owner => "serf", config_group => "serf" }' }
    it { should contain_file('/etc/serf').with(:group=>'serf',:owner=>'serf') }
    it { should contain_file('/etc/serf/serf.conf').with(:group=>'serf',:owner=>'serf') }
  end

  context 'should notify service on any change' do
    let(:pre_condition) { 'include serf' }
    it { should contain_file('/etc/serf/serf.conf').that_notifies('Service[serf]')}
  end

  context 'bind_addr key' do
    context '< 0.3.0' do
      let(:pre_condition) { 'class { "serf": version => "0.2.9" }' }
      it { should contain_file('/etc/serf/serf.conf').with_content(/\"bind_addr\":/) }
      it { should contain_file('/etc/serf/serf.conf').without_content(/\"bind\":/) }
    end
    context '> 0.3.0' do
      let(:pre_condition) { 'class { "serf": version => "0.3.0" }' }
      it { should contain_file('/etc/serf/serf.conf').without_content(/\"bind_addr\":/) }
      it { should contain_file('/etc/serf/serf.conf').with_content(/\"bind\"\:/) }
    end
  end
  context 'role key' do
    context '= 0.3.0' do
      let(:pre_condition) { 'class { "serf": version => "0.3.0", role=>"abc" }' }
      it { should contain_file('/etc/serf/serf.conf').with_content(/\"role\":/) }
      it { should contain_file('/etc/serf/serf.conf').without_content(/\"tag\":/) }
    end
    context '> 0.4.0' do
      let(:pre_condition) { 'class { "serf": version => "0.4.0", role=>"abc" }' }
      it { should contain_file('/etc/serf/serf.conf').with_content(/\"tag\"\:/) }
      it { should contain_file('/etc/serf/serf.conf').without_content(/\"role\":/) }
    end
  end

end
