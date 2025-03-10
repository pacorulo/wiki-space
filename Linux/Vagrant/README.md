# Vagrant
Vagrantfile I put in this repo is an easy one to create VM's to test whatever locally or to be used to test something like a C\* driver against an instance placed in the cloud, etc.

## Configurations related

## Main vagrant files
Main vagrant files are stored under `.vagrant/machines/<vm_hostname>/virtualbox/`

### Defining networks
By editing /etc/vbox/networks.conf we can define the ip ranges we want to use in our vagrant VM's, that can be something like (or whatever you would prefer):
```
* 192.168.1.0/24
* 192.168.56.0/24
```

## [Command-Line Interface](https://developer.hashicorp.com/vagrant/docs/cli)
### Personal Aliases
```
alias v='vagrant'
alias vu='vagrant up'
alias vh='vagrant halt'
alias vssh='vagrant ssh'
alias vsts='vagrant status'
alias vgsts='vagrant global-status'
alias vdes='vagrant destroy -f' #Be careful when using it!!!
```
### More commands
#### Related to the start up process
- `vagrant resume` to resume a suspended VM
- `vagrant provision` to force reprovisioning the VM
- `vagrant reload` to restart a VM when there was a config change so it gets loaded (last two can be executed in one shot with: `vagrant reload --provision`)
#### [Boxes](https://developer.hashicorp.com/vagrant/docs/cli/box)
- `vagrant box list` to list all already downloaded/installed boxes
- `vagrant box add <name> <url>`
- `vagrant box outdated` to look for updates on currently installed boxes
- `vagrant box remove <name>`
#### [Plugins](https://developer.hashicorp.com/vagrant/docs/cli/plugin)
- `vagrant plugin install <plugin_name>` where an example can be `vagrant-disksize`
#### [SSH Config](https://developer.hashicorp.com/vagrant/docs/cli/ssh_config)
- `vagrant ssh-config [name|id]`
#### Autocomplete commands
- `vagrant autocomplete install --bash --zsh` (by installing it autocomplete will work for vagrant commands in bash and zsh)
#### [Snapshots](https://developer.hashicorp.com/vagrant/docs/cli/snapshot)
We need to take care when using the snapshot tool/command as we can use it with `push` and `pop` or `save` and `restore` but taking care of what dupla we are using due to issues when commands from both are mixed.
