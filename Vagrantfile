# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"

  # Hostname
  config.vm.host_name = 'vagrantrailsbox'


  # The url from where the 'config.vm.box' box will be fetched 
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"


  # accessing "localhost:3000" will access port 3000 on the guest machine.
  config.vm.network :forwarded_port, guest: 3000, host: 3000


  # using a specific IP.
  # config.vm.network :private_network, ip: "10.4.4.58"


  # If true, then any SSH connections made will enable agent forwarding.
  # config.ssh.forward_agent = true


  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder.
  #config.vm.synced_folder '--YourSharedFolder---', '/home/vagrant/code', :nfs=> false


  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  #config.vm.provider :virtualbox do |v|
  #  v.customize ["modifyvm", :id, "--memory", "4000"]
  #  v.customize ["modifyvm", :id, "--cpuexecutioncap", "95"]
  #  v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  #  v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  #end


  #Provision
  config.vm.provision :puppet,
    :manifests_path => 'puppet/manifests',
    :module_path    => 'puppet/modules'

end
