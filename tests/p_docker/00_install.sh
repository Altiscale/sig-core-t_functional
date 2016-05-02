

t_Log "$0 - installing docker"
t_InstallPackage docker-io 

t_CheckExitStatus $? 'Fail: Can not install docker'
