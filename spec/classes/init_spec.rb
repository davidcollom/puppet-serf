require 'spec_helper'

describe 'serf' do
  it { should compile }
  it { should compile.with_all_deps }
  it { should contain_class('serf::install') }
  it { should contain_class('serf::config') }
  it { should contain_class('serf::service') }

  context 'relationship order' do
    it { should contain_class('serf::install').that_comes_before('Class[serf::config]') }
    it { should contain_class('serf::config').that_requires('Class[serf::install]') }
    it { should contain_class('serf::config').that_notifies('Class[serf::service]')}
  end

  context 'on Unsupported OS' do
    let(:facts) { {:osfamily=>'Windows'}}
    it do
      expect {
        should compile
      }.to raise_error(Puppet::Error, /Operating system (.*) is not supported yet/)
    end
  end

end
