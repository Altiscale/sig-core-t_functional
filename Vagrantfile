disks = [1024, 2048, 1024, 2048]
load File.expand_path('.vagrant/tmp/remote_vagrantfile')

Vagrant.configure(2) do |config|

  config.functional.tests = %w{
    p_docker p_zfs p_bfq p_systemtap p_bash p_collectd
    p_abrt p_abrt-cli p_acl p_amanda p_arpwatch p_attr p_audit p_autofs p_bc p_bind p_bridge-utils p_busybox p_bzip2
    p_chkconfig p_coreutils p_cpio p_cracklib p_cron p_curl p_dovecot p_exim p_file p_findutils p_freeradius
    p_gcc p_grep p_grub p_grub2 p_gzip p_httpd p_initscripts p_ipa-server p_iptraf p_iputils p_jwhois
    p_lftp p_logrotate p_logwatch p_lsb p_lsof p_lynx p_lzop p_mailman p_mdadm p_minicom p_mod_python p_mod_wsgi p_mtr p_mysql p_net-snmp
    p_network p_nfs p_nmap p_ntp p_openssh p_openssl p_passwd p_perl p_php p_postfix p_postgresql p_procinfo p_python p_rootfiles p_rpm p_rrdtool
    p_rsync p_ruby p_samba p_screen p_selinux p_sendmail p_setup p_shadow-utils p_shim p_spamassassin p_sqlite p_squid p_squirrelmail p_strace
    p_subversion p_syslog p_sysstat p_tar p_tcl p_tcpdump p_telnet p_tftp-server p_tmpwatch p_tomcat p_traceroute p_vconfig
    p_vsftpd p_webalizer p_wget p_which p_xorg-x11-server p_yum p_zip
  }

  config.vm.provider :virtualbox do |vb|
    disks.each_with_index do | disk_size, index |
      disk_file = ".virtual_disks/virtual_disk#{index}.vdi"
      vb.customize ["createhd",  "--filename", disk_file, "--size", disk_size]
      vb.customize ["storageattach", :id, "--storagectl", "prometheus-storage-0", "--port", index + 1, "--type", "hdd", "--medium", disk_file]
    end
  end
  config.vm.synced_folder ".", "/t_functional", type: "rsync"
end
