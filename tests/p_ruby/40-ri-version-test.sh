#!/bin/sh

t_Log "Running $0 - Check version of ruby ri."

if [ "$centos_ver" = "7" ] ; then
  # We don't use centos 7
  ret_val=1
else
  ri -v | grep -q '4.0.0'
  ret_val=$?
fi

t_CheckExitStatus $ret_val

