# -*- mode: ruby -*-
# vi: set ft=ruby :

TARGET_COUNT = 2

Vagrant.configure("2") do |config|
  targets = []
  hosts = { 'python3' => '10.0.0.200' }

  TARGET_COUNT.times do |i|
    hosts["python2-#{i}"] = "10.0.0.#{100 + i}"
    targets << "python2-#{i}"
  end

  config.vm.define "python3" do |python3|
    python3.vm.box = "centos/7"
    python3.vm.hostname = "python3"
    python3.vm.network "private_network", ip: "10.0.0.200"

    python3.vm.provision "shell", privileged: true, inline: <<~INSTALL_PYTHON
      sudo yum install -y python3
      ln -sf /usr/bin/python3 /usr/bin/python
    INSTALL_PYTHON
  end

  targets.each do |target_name|
    config.vm.define(target_name) do |target|
      target.vm.box = "centos/7"
      target.vm.hostname = target_name
      target.vm.network "private_network", ip: hosts[target_name]

      target.vm.provision "shell", privileged: true, inline: <<~INSTALL_PYTHON
      sudo yum install -y python zlib zlib-devel wget
      INSTALL_PYTHON
    end
  end
end
