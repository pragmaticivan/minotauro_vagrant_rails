# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define 'minotauro' do |machine|
      machine.vm.box = "precise64"
      machine.vm.box_url = "http://files.vagrantup.com/precise64.box"
      machine.vm.hostname = 'minotaurorailsbox'
      machine.vm.network "private_network", ip: "10.0.10.50"
      machine.vm.network "forwarded_port", guest: 3000, host: 3000

      # Share an additional folder to the guest VM. The first argument is
      # the path on the host to the actual folder. The second argument is
      # the path on the guest to mount the folder. And the optional third
      # argument is a set of non-required options.
      # config.vm.synced_folder "../data", "/vagrant_data"
      # config.vm.synced_folder('----localfolder-----', '/home/vagrant/code', :nfs => true)
      machine.vm.synced_folder '~/', '/home/vagrant/code', :nfs => true

      machine.vm.provision "ansible" do |ansible|
          ansible.playbook = "provisioning/playbook.yml"
          ansible.limit = 'all'
          ansible.verbose = "vvv"
          ansible.sudo = "true"
          # ansible.tags = 'postgresql'
      end

      machine.vm.provider "virtualbox" do |v|

        # Use VBoxManage to customize the VM. For example to change memory:
        v.customize ["modifyvm", :id, "--memory", "1024"]
        v.customize ["modifyvm", :id, "--cpuexecutioncap", "95"]
      end
    end

end

