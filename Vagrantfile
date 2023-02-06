# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
hosts = YAML.load_file('hosts.yml')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
# Check for missing plugins
  required_plugins = %w(vagrant-hostmanager)
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

  # Optionnel pour travailler avec un pool de stockage différent - penser à le creer
  config.vm.provider :libvirt do |libvirt|
    # CREATE STORAGE POOL libvirt-pool1 FIRST
    libvirt.storage_pool_name="libvirt-pool1"
    libvirt.driver="kvm"
    libvirt.uri="qemu:///system"
  end

  hosts.each do |host|
    config.vm.define host['name'] do |node|
      node.vm.hostname = host['name']
      node.vm.network :private_network, ip: host['ip']
# ------------------- Box Section -------------------------------      
      node.vm.box = host['os'] 
# ------------------- Provisioning Section -------------------------------
      if host['provisioner'] == 'shell'
        node.vm.provision "shell",privileged: true, path: host['playbook']
      else
        node.vm.provision "ansible" do |ansible|
          ansible.playbook = host['playbook']
          ansible.verbose = "v"
        end
      end

      #node.vm.provision "shell",privileged: true, path: "copy_docker_login.sh"
      node.vm.provision "shell",privileged: true, path: "install_kube.sh"
      if host['manager'] == true
      	node.vm.provision "shell",privileged: false, path: "manager_setup.sh"
      end
      node.vm.provider :libvirt do |d|
        d.memory = host['mem']
        d.graphics_type = "none"
        d.cpus = host['cpus']
      end
    end
  end
end
