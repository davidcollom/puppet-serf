require 'spec_helper'

describe 'serf::install' do
  context 'with defaults' do
    it { should contain_exec('download_serf') }
    it { should contain_exec('unzip_serf') }
    it { should contain_exec('install_serf') }
  end
end
