# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu-1204"
  config.vm.network :private_network, ip: "192.168.33.10"
  
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "../"
    puppet.manifests_path = "tests"
    puppet.manifest_file  = "init.pp"
    puppet.options = "--verbose --debug"
  end

end
