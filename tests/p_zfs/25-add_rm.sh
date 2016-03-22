t_Log "Running $0 - Attach/Detach zpool test"

zpool create tank sdb sdc -f

t_Log 'Attaching disk to zpool'
zpool attach tank sdb /dev/sdd
t_CheckExitStatus $? 'Fail: Can not attach disk to zpool'

t_Log 'Detaching a disk from zpool'
zpool detach tank sdb
t_CheckExitStatus $? 'Fail: Can not detach disk from zpool'

zpool destroy tank

zpool create tank sdb sdc -f
t_Log 'Adding a mirror to the zpool'
zpool add tank mirror -f sdd sde
t_CheckExitStatus $? 'Fail: Can not add mirror to existing zpool'

zpool destroy tank
