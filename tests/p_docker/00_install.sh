
t_Log "Installing certificates"

chef-solo -j <(echo '{"run_list":"recipe[centos_base::certificates]","altiscale":{"certificates":{"environments":["staging"]}}}')

t_Log "$0 - installing docker"

t_InstallPackage docker-io

t_CheckExitStatus $? 'Fail: Can not install docker'

t_ServiceControl docker start
