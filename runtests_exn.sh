#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ "`which sudo`" = "" ]
then
    SUDO=''
else
    SUDO='sudo'
fi

skip_suits=(p_anaconda p_bfq p_centos-release p_collectd p_docker p_httpd p_iptables p_kernel p_lftp p_libvirt p_mailman p_mod_wsgi p_postfix p_ruby p_systemtap p_webalizer p_xorg-x11-server p_yum-plugin-fastestmirror p_yum p_zfs r_lamp z_rpminfo)

for f in ${skip_suits[@]}; do
    chmod a-x ./tests/${f}/*
done

${SUDO} ./runtests.sh

exit 0
