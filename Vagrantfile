VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"


  config.vm.network "private_network", ip: "192.168.33.10"

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end


  config.vm.provision "puppet" do |puppet|
    puppet.options = "--verbose --debug"

    puppet.module_path = "modules"

    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "nodes/default.pp"

    puppet.hiera_config_path = "hiera.yaml"
    puppet.working_directory = "/vagrant/hiera/"
  end
end
