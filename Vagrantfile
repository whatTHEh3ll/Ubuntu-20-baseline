# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.hostname = "development-ubuntu-20"
  #config.disksize.size = '128GB'
  # use for dhcp
  # config.vm.network "private_network", type: "dhcp"
  config.vm.network "public_network", ip: "192.168.1.173", bridge: "wlo1"
  #config.vm.network "private_network", ip: "192.168.56.173"
    config.vm.provider "virtualbox" do |v|
          v.memory = 4096
          v.cpus = 2
      end
    ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_ed25519.pub").first.strip
    config.vm.provision 'shell', inline: 'mkdir -p /root/.ssh'
    config.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /root/.ssh/authorized_keys"
    config.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys", privileged: false
    config.vm.provision 'shell', inline: 'echo "vagrant:a" | chpasswd'
    config.vm.provision 'shell', inline: "apt update -y", privileged: true  
    config.vm.provision 'shell', inline: "apt -y install python3", privileged: true
    # config.vm.provision "shell", path: "swap.sh", privileged: true
    config.vm.synced_folder "Projects", "/home/vagrant/Projects"
    end

Vagrant.configure("2") do |config|
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision.yml"
     ansible.become = "True"
     #ansible.verbose = "vv"
     ansible.limit = "all"
     ansible.inventory_path = "hosts.ini"
     ansible.config_file = "ansible.cfg"
     #ansible.vault_password_file = ""
     #ansible.start_at_task = "update Suricata rules"
     #ansible.skip_tags = ""
     #ansible.tags = "suricata"
     ansible.force_remote_user = true
  end
end
   
  
