#!/usr/bin/env bash

# call with the platform parameter  vagrant|ec2|docker

set -o errexit
set -o pipefail
set -o nounset

if [ "`which sudo`" = "" ]
then
    SUDO=''
else
    SUDO='sudo'
fi

env=$1

skip_suits=(p_anaconda p_bfq p_centos-release p_collectd p_docker p_httpd p_iptables p_kernel p_lftp p_libvirt p_mailman p_mod_wsgi p_postfix p_ruby p_systemtap p_webalizer p_xorg-x11-server p_yum-plugin -fastestmirror p_yum p_zfs)

if [ "$env" == "ec2" ]; then
    skip_suits+=(r_lamp z_rpminfo p_network p_ntp p_vconfig p_iputils)
elif [ "$env" == "docker" ]; then
    skip_suits+=(p_amanda p_arpwatch p_audit p_autofs p_bridge-utils p_initscripts p_nfs p_samba p_selinux p_sendmail p_strace p_syslog p_tmpwatch)
fi

for f in ${skip_suits[@]}; do
    chmod a-x ./tests/${f}/*
done

# Without this, git suit fails.
${SUDO} git config --global user.email "centos_tester@example.com"
${SUDO} git config --global user.name "Centos Tester"

${SUDO} ./runtests.sh

