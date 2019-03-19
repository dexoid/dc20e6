# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

settings = YAML.load_file('config.yml')["settings"]

Vagrant.configure(2) do |config|
  config.vm.define settings['hostname'] do |config|
    config.vm.box = "centos/7"
    config.vm.hostname = settings['hostname']
    config.vm.network "private_network", ip: settings['ip']
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
    config.vm.box_check_update = true
    config.vm.provision "shell" do |script|
      script.path = "scripts/provision.sh"
      script.args = [settings['remotehostname'], settings['remoteip']]
    end
    config.vm.provision "file", source: "master", destination: "/tmp/master"
    config.vm.synced_folder settings['saltdir'], "/srv/salt/"

  end
end
