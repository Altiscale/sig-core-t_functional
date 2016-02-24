#!/bin/sh

t_Log "Running $0 - Check version of ruby."

if [ "$centos_ver" = "7" ] ; then
  # We don't use centos 7
  ret_val=1
elif [ "$centos_ver" = "6" ] ; then
  ruby -v | grep -q '2.0.0'
  ret_val=$?
else
  # We don't use centos 5
  ret_val=1
fi

t_CheckExitStatus $ret_val

