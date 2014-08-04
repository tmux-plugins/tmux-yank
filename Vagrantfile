VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise32'
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'

  config.vm.provision 'shell', path: 'vagrant_provisioning.sh'

  config.ssh.forward_x11 = true
end
