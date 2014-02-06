#puppet-[Serf](http://www.serfdom.io)

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/davidcollom/puppet-serf/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
[![Build Status](https://travis-ci.org/davidcollom/puppet-serf.png?branch=master)](https://travis-ci.org/davidcollom/puppet-serf)

##Overview

The Serf module installs, configures, and manages a Serf agent.

Firewall ports must be managed elsewhere.  If using default serf configuration, ensure that 7946 is open for serf node communication, and 7373 for RPC.


##Module Description

The Serf module manages the installation and configuration of Serf

##Setup
```puppet
puppet module install davidcollom/serf
```

##Usage

With defaults:
```puppet
include serf
```

On AWS, with sample event handler:
```puppet
class{'serf':
    bind           => $::ec2_public_ipv4,
    sample_handler => true,
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

#####`sample_handler`
Defaults to `false`, but if set to `true` this will install a sample event handler bash script.

#####`handler_home`
Defaults to `/opt/serf` and only used if `sample_handler` is true: where to install the handler script.

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

### Authors


This module is based on the example provided by Mitchell Hashimoto at [https://github.com/hashicorp/serf/](https://github.com/hashicorp/serf/blob/master/demo/web-load-balancer/setup_serf.sh)
