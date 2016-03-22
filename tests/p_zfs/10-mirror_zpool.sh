t_Log "Running $0 - Zpool mirror test"

t_Log 'Creating a mirrored zpool'
zpool create tank mirror sdb sdc mirror sdd sde -f
t_CheckExitStatus $? 'Fail: Can not create striped mirrored zpools'

echo 'some text in a file' >/tank/file_in_zfs

t_Log 'Offlining mirrors'
zpool offline tank /dev/sdc
zpool status | grep 'sdc\s\+OFFLINE' >/dev/null
t_CheckExitStatus $? 'Fail: sdc is not OFFLINE'

zpool status | grep 'mirror-0\s\+DEGRADED' >/dev/null
t_CheckExitStatus $? 'Fail: mirror-0 is not DEGRADED'

zpool offline tank /dev/sde
t_CheckExitStatus $?

zpool status | grep 'mirror-1\s\+DEGRADED' >/dev/null
t_CheckExitStatus $?

grep 'some text in a file' /tank/file_in_zfs >/dev/null
t_CheckExitStatus $? 'Fail: Data in ZFS did not survive disk offline'

zpool destroy tank
