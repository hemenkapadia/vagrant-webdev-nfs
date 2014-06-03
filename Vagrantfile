# Reference @ https://github.com/purple52/librarian-puppet-vagrant

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	
	config.vm.box = "hashicorp/precise32"
# config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  
  config.vm.network "private_network", ip: "192.168.10.110"
  config.vm.synced_folder "../vagrant-webdev-workspace", "/home/vagrant/workspace"
 
  config.vm.provider "virtualbox" do |vb|
#		vb.gui = true   (uncomment to enable GUI on guest)
    vb.customize ["modifyvm", :id, "--memory", "400"]   # 400 MB
  end

	config.vm.provision :shell, :path => 'shell/main.sh'
	
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "main.pp"
  end
  
end
