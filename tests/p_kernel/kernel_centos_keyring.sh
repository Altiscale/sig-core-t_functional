#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Note: This was a known issue with CentOS 6.0 GA kernel

t_Log "Running $0 -  check CentOS' Kernel Module GPG key."

if [ "$centos_ver" = "7" ] ; then
  for id in kpatch "Driver Update" kernel
  do
    t_Log "Verifying x.509 CentOS ${id}"
    grep 'CentOS Linux ${id} signing key' /var/log/dmesg > /dev/null 2>&1
    t_CheckExitStatus $?
  done
else
  grep 'User ID: CentOS (Kernel Module GPG key)' /var/log/dmesg > /dev/null 2>&1
  t_CheckExitStatus $?
fi

