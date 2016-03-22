#!/bin/bash

t_Log "$0 - installing ZFS"
t_InstallPackage zfs

lsmod | awk '$1 == "zfs"' | grep zfs>/dev/null && \
{
  t_Log "ZFS module is already loaded, unloading it"
  modprobe -r zfs
  t_CheckExitStatus $? 'Fail: Can not unload an already loaded ZFS module'
}

t_Log 'Loading ZFS module'
/sbin/modprobe zfs
t_CheckExitStatus $? 'Fail: Can not load ZFS module'
