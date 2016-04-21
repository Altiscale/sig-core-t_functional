#!/bin/bash

t_Log "$0 - installing ZFS"
t_InstallPackage systemtap

t_Log "Running hello world systemtap onliner"
echo 'probe begin { printf("hello systemtap"); exit(); }' | stap -
t_CheckExitStatus $? 'Fail: Can not unload an already loaded ZFS module'

