#!/bin/sh

t_Log "Running $0 - Check version of irb."

if [ "$centos_ver" = "7" ] ; then
  # We don't use centos 7
  ret_val=1
else
  irb -v | grep -q '0.9.6'
  ret_val=$?
fi

t_CheckExitStatus $ret_val
