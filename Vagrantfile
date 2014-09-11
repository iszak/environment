VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"


  config.vm.network "private_network", ip: "192.168.33.10"


  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end


  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "puppet/modules"

    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "default.pp"
  end
end
