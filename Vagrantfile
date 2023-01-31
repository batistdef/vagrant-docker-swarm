# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
hosts = YAML.load_file('hosts.yml')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
# Check for missing plugins
  required_plugins = %w(vagrant-disksize vagrant-hostmanager vagrant-vbguest vagrant-clean)
  plugin_installed = false
  required_plugins.each do |plugin|
    unless Vagrant.has_plugin?(plugin)
          system "vagrant plugin install #{plugin}"  
      plugin_installed = true
    end
  end

  # If new plugins installed, restart Vagrant process
  if plugin_installed === true
    exec "vagrant #{ARGV.join' '}"
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.include_offline= true
  config.hostmanager.ignore_private_ip = false

  config.vm.box_check_update = false
  config.vbguest.auto_update = false

  hosts.each do |host|
    config.vm.define host['name'] do |node|
      node.vm.hostname = host['name']
      node.vm.network :private_network, ip: host['ip']
      node.disksize.size = host['size']
# ------------------- Box Section -------------------------------      
      node.vm.box = host['os'] 
# ------------------- Provisioning Section -------------------------------
      if host['provisioner'] == 'shell'
        node.vm.provision "shell",privileged: true, path: host['playbook']
      else
        node.vm.provision "ansible_local" do |ansible|
          ansible.playbook = host['playbook']
          ansible.verbose = "False"
        end
      end
      node.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.name = host['name']
        vb.customize ["modifyvm", :id, "--memory", host['mem'], "--cpus", host['cpus'], "--hwvirtex", "on","--groups", "/DevOps-Lab",
        "--natdnshostresolver1", "on", "--cableconnected1", "on"]
      end      
    end
  end
end
