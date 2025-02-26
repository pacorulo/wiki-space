# Vagrant
Vagrantfile I put in this repo is an easy one to create VM's to test whatever locally or to be used to test something like a C\* driver against an instance placed in the cloud, etc.

By editing /etc/vbox/networks.conf we can define the ip ranges we want to use in our vagrant VM's, that can be something like (or whatever you would prefer):
```
* 192.168.1.0/24
* 192.168.56.0/24
```
