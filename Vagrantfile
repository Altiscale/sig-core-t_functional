
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  machines = [
    #{ name: "centos7", box: "centos-7" },
    {
      name: "prometheus-6.5.14",
      box: "prometheus-6.5.14-201602120407",
      box_url: '"https://s3-us-west-1.amazonaws.com/com.altiscale.vagrant/prometheus/boxes/prometheus-6.5.14-201602120407.box?AWSAccessKeyId=AKIAIKOVEEW6FVT5JBQA&Expires=1770868554&Signature=YIhNZGY0VRD%2Bs9Z8PopwRgrvBbA%3D"',
      disks: [1024, 2048, 1024, 2048]
    }
  ]

  machines.each do | machine |
    mem = machine[:ram] || "2048"
    cpu = machine[:cpu] || "2"
    hname = machine[:hostname] || "#{machine[:name]}.test.altiscale.com"
    box = machine[:box]
    name = machine[:name]
    box_url = machine[:box_url]
    disks = machine[:disks]

    config.vm.define name do | myvm |
      myvm.vm.provider :virtualbox do |vbox|
        vbox.customize ['modifyvm', :id, '--memory', mem, '--cpus', cpu, '--ioapic', 'on']
        disks.each_with_index do | disk_size, index |
          disk_file = "virtual_disks/#{machine[:name]}_disk#{index}.vdi"
          vbox.customize ["createhd",  "--filename", disk_file, "--size", disk_size]
          vbox.customize ["storageattach", :id, "--storagectl", "prometheus-storage-0", "--port", index + 1, "--type", "hdd", "--medium", disk_file]
        end
      end
      myvm.vm.box = box
      myvm.vm.hostname = hname
      myvm.vm.box_url = box_url
      myvm.vm.synced_folder ".", "/t_functional", type: "rsync"
    end
  end
end
