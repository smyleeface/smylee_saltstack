# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|

  ##### ----- BASIC CENTOS AND NGINX SETUP
  config.vm.define :server do |srv|

    srv.vm.box = "smylee_box"

    #configured box: packer build centos68.json
    srv.vm.box_url = "packer/build/centos-6.8-x86_64.box"

    #hostname the machine will have
    srv.vm.hostname = "smylee-server"

    #environment running on http://stackoverflow.com/questions/26811089/vagrant-how-to-have-host-platform-specific-provisioning-steps
    module OS
      def OS.windows?
          (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      end

      def OS.mac?
          (/darwin/ =~ RUBY_PLATFORM) != nil
      end

      def OS.unix?
          !OS.windows?
      end

      def OS.linux?
          OS.unix? and not OS.mac?
      end
    end

    #use localhost:8080
    if OS.windows?
        config.vm.network :forwarded_port, guest: 80, host: 80, auto_correct: true
        config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct: true
    elsif OS.mac?
        config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct: true
    elsif OS.unix?
        config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct: true
    elsif OS.linux?
        config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct: true
    else
        config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct: true
    end

    config.vm.network :forwarded_port, guest: 8888, host: 8888, auto_correct: true

    #use ip addy instead of localhost (mac only)
    # config.vm.network "private_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.0.24"

    # Share for masterless server
    srv.vm.synced_folder "salt/server/", "/srv/"

    #provision salt after os install
    srv.vm.provision :salt do |salt|

      # Configure the minion
      salt.minion_config = "salt/server/minion.conf"

      # Show the output of salt
      salt.verbose = true
      salt.colorize = true

      # Pre-distribute these keys on our local installation
      salt.minion_key = "salt/salt/keys/vagrant71.pem"
      salt.minion_pub = "salt/salt/keys/vagrant71.pub"

      # Run the highstate on start
      salt.run_highstate = true

      # Install the latest version of SaltStack
      salt.install_type = "stable"
      salt.log_level = "warning" #"all", "garbage", "trace", "debug", "info", or "warning".
      salt.bootstrap_options = "-F -c /tmp -P"

    end #config.srv.provision

    # Customize the box
    srv.vm.provider :virtualbox do |v|
      # v.gui = true
      v.customize ["modifyvm", :id, "--memory", 2048]
    end

  end #config.vm.define

end
