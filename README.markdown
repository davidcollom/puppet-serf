#puppet-[Serf](http://www.serfdom.io)

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/davidcollom/puppet-serf/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
[![Build Status](https://travis-ci.org/davidcollom/puppet-serf.png?branch=master)](https://travis-ci.org/davidcollom/puppet-serf)

##Overview

The Serf module installs, configures, and manages a Serf agent.

##Module Description

The Serf module manages the installation and configuration of Serf

##Setup
```puppet
include serf
```

##Usage
```puppet
class{'serf':
    bind            =>  $::ipaddress_eth1
    event_handler   =>  ['/root/bin/handler.sh']
}
```

###Parameters

#####`version`
The version you wish to install

#####`bind`
The address that Serf will bind to for communication with other Serf nodes

__Note__ Changing the bind port also requires you specify the `rpc_addr` otherwise `rpc_addr` will remain the default `$::ipaddress` fact

#####`config_dir`
The directory you wish to store the serf config file in, defaults to: '/etc/serf/'

#####`config_file`
The name of the config file you wish to be generated, stored within config_dir
eg:```${config_dir}/${config_file}```

#####`encrypt`
Secret key to use for encryption of Serf network traffic

#####`event_handler`
Array of event handlers, **NOTE**: No validation is performed if these files exist.

#####`join`
Array of IP's known to the Serf network already, This was added to allow for hiera data to be passed and allow for a "master" node which is aware of all serf clusters but is in a "monitoring" state.

#####`log_level`
Change logging levels, Added for debugging purposes, defaults to: ```info```
#####`node`
Node name, defaults to $fqdn

#####`protocol`
Protocol Version to use- this is for backwards compatability and defaults to 1

#####`role`
Optional Role for specific node

#####`rpc_addr`
The address that Serf will bind to for the agent's internal RPC server, defaults to: ```"${::ipaddress}:7373"```

#####`advertise`
The address that Serf will provide to other nodes to reach it; defaults to ```${::ipaddress}`.

Eg:
```
$::ipaddress='10.5.2.xxx'
class{'serf':
    bind => '10.6.2.xxxx'
}
```
rpc_addr would be ```'10.5.2.xxxx:7373'```


#####`install_path` (Private)
Installation path to install serf executable, this should be within your normal users path.
defaults to: ```/usr/local/bin```

#####`install_url`
Where to download serf from, this defaults to: ```https://dl.bintray.com/mitchellh/serf/${version}_linux_${::architecture}.zip```

#####`install_method`
Defaults to `url` but can be `package` if you want to install via a system package.

#####`package_name`
Only valid when the install_method == package. Defaults to `serf`.

#####`package_ensure`
Only valid when the install_method == package. Defaults to `present`.

#####`config_owner` and `config_group`
Specify who is to become owner of ```$config_file```

##Limitations

This module has been tested on:

* Ubuntu 12.04
* CentOS 6.4

Testing on other platforms has been light and cannot be guaranteed.

## Vagrant example

1. Install [Vagrant](http://vagrantup.com) and [VirtualBox](http://virtualbox.org)
2. Clone this repository: `git clone https://github.com/danieldreier/serf-demo.git`
3. `cd serf-demo` then run `vagrant up node0` and wait for the first node to start
4. `vagrant ssh -c 'serf monitor' node0` to monitor the communication the first node sees
5. in another terminal window, run `vagrant up` and watch members join the cluster
6. `vagrant ssh node1` then run `serf event foo bar` will trigger an event titled "foo" with a payload "bar"
7. On node1, run `serf members` to get a list of serf cluster members
8. `exit` out to your regular command line, run `vagrant halt node2`, then repeat step 7 to see node2's status change to 'failed'.

When you're done, run `vagrant halt` to shut them down, or `vagrant destroy` to remove the VMs entirely.

You can modify the number of nodes created by editing `INSTANCES=5` in the Vagrantfile to some other value, then running `vagrant up` again to bring up the new nodes. If you add other services to the nodes, you'll probably need to increase `MEMORY=128` to `MEMORY=256` or greater.


### Authors


This module is based on the example provided by Mitchell Hashimoto at [https://github.com/hashicorp/serf/](https://github.com/hashicorp/serf/blob/master/demo/web-load-balancer/setup_serf.sh)
