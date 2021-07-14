Vagrant.configure("2") do |config|

#Consul-Server Configuration
serverIp = "192.168.99.100"
config.vm.define "consul-server" do |cServ| 
  cServ.vm.box = "ubuntu/xenial64"
  serverInit = %(
	{
		"server": true,
		"ui": true,
		"advertise_addr": "#{serverIp}",
		"client_addr": "0.0.0.0",
		"data_dir": "/tmp/consul",
		"bootstrap_expect": 1
	}
  )
  cServ.vm.provider "virtualbox" do |cVM|
		cVM.memory = 1024
		cVM.cpus = 1
  end		
  cServ.vm.hostname = "consul-server"
  cServ.vm.network "forwarded_port", guest: 8500, host: 8500
  cServ.vm.network "private_network", ip: serverIp
  cServ.vm.provision "shell", path: "consul_provision.sh"
  cServ.vm.provision "shell", inline: "echo '#{serverInit}' > /etc/systemd/system/consul.d/init.json" 
  cServ.vm.provision "shell", inline: "service consul start"
end

#Apache-Client Configuration
config.vm.define "apache" do |apache|
	apache.vm.box = "ubuntu/xenial64"
	clientIp = "192.168.99.101"
	clientInit = %(
		{
		"server": false,
		"advertise_addr": "#{clientIp}",
		"data_dir": "/tmp/consul",
		"retry_join": ["#{serverIp}"],
		"enable_script_checks": true,
		"ui": true
		})
	apache.vm.provider "virtualbox" do |aVM|
		aVM.memory = 1024
		aVM.cpus = 1
	end
	apache.vm.hostname ="apache-client"
	apache.vm.network "forwarded_port", guest: 8080, host: 8080
	apache.vm.network "private_network", ip: clientIp
	apache.vm.provision "shell", path: "consul_provision.sh"
	apache.vm.provision "shell", path: "apache_provision.sh"
	apache.vm.provision "shell", inline: "echo '#{clientInit}' > /etc/systemd/system/consul.d/init.json" 
	apache.vm.provision "shell", inline: "service consul start"
	apache.vm.provision "shell", inline: "consul services register /vagrant/web.json"
end

end