def synced_folder(config, src, dst)
  config.vm.synced_folder src, dst,
    type: 'virtiofs'
end

Vagrant.configure("2") do |c|
  c.vm.define 'ubuntu', primary: true do |ubuntu|
    ubuntu.vm.box = 'bento/ubuntu-24.04'
    ubuntu.vm.hostname = 'ubuntu'

    synced_folder(ubuntu, __dir__, '/vagrant')

    ubuntu.vm.provider 'libvirt' do |libvirt|
      libvirt.cpus = 18
      libvirt.memory = 32768
      libvirt.memorybacking :access, :mode => "shared"
    end
  end
end
