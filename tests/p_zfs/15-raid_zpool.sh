t_Log "Running $0 - Various zpool Raid test"

t_Log 'Creating a zpool of raidz and mirror'
zpool create tank raidz sdb sdc mirror sdd sde -f
t_CheckExitStatus $? 'Fail: Can not create a raidz1 zpool'

zpool destroy tank

t_Log 'Creating a zpool of raidz2 and raidz'
dd if=/dev/zero of=/zfs1 bs=1 count=1 seek=4100G 2>/dev/null
zpool create tank raidz2 sdb sdc sdd raidz sde /zfs1 -f
t_CheckExitStatus $? 'Fail: Can not create zpool of raidz2 and raidz'

zpool destroy tank

t_Log 'Creating a zpool of raidz3'
zpool create tank raidz3 sdb sdc sdd sde -f
t_CheckExitStatus $? 'Fail: Can not create a zpool of raidz3'

zpool destroy tank
