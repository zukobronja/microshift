# Author: Zuko Bronja
Vagrant.configure("2") do |config|
    config.vm.box = "fedora/35-cloud-base"

    config.vm.network "public_network", bridge: "wlp3s0"

    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 443, host: 8443
    config.vm.network "forwarded_port", guest: 5353, host: 5353, protocol: "udp"
    config.vm.network "forwarded_port", guest: 6443, host: 6443

    config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.name = "microshift"
        vb.memory = "4192"
        vb.cpus = "2"
    end

    config.vm.provision :shell, path: "bootstrap.sh"

end
