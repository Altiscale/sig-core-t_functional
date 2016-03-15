
t_Log "Running $0 -  Check basic ZFS functionality"
t_Log 'Creating basic zpool'
zpool create tank -f sdb sdc sdd sde
t_CheckExitStatus $? 'Fail: Can not create basic zpool'

t_Log 'Checking /tank mountpoint'
df -h  /tank >/dev/null
t_CheckExitStatus $? 'Fail: Can not find /tank mountpoint'

t_Log 'Check if /tank is writable'
echo 'test data' > /tank/test_file
t_CheckExitStatus $? ''

t_Log 'Destroying zpool'
zpool destroy tank
t_CheckExitStatus $? 'Fail: Can not destroy a basic zpool'
