require 'spec_helper'

describe 'serf' do
  it { should compile }
  it { should contain_class('serf::install') }
  it { should contain_class('serf::config') }
  it { should contain_class('serf::service') }

  context 'relationship order' do
    it { should contain_class('serf::install').that_comes_before('Class[serf::config]') }
    xit { should contain_class('serf::config').that_comes_before('Class[serf::service]') }
    xit { should contain_class('serf::service').that_comes_after('Class[service::config]') }
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
