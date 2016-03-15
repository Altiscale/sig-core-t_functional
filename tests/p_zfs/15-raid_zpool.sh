t_Log "Running $0 - Various zpool Raid test"

t_Log 'Creating a zpool of raidz and mirror'
zpool create tank raidz /dev/sdb /dev/sdc mirror /dev/sdd /dev/sde -f
t_CheckExitStatus $? 'Fail: Can not create a raidz1 zpool'

zpool destroy tank

t_Log 'Creating a zpool of raidz2 and raidz'
dd if=/dev/zero of=/zfs1 bs=1 count=1 seek=4100G 2>/dev/null
zpool create tank raidz2 /dev/sdb /dev/sdc /dev/sdd raidz /dev/sde /zfs1 -f
t_CheckExitStatus $? 'Fail: Can not create zpool of raidz2 and raidz'

zpool destroy tank

t_Log 'Creating a zpool of raidz3'
zpool create tank raidz3 /dev/sdb /dev/sdc /dev/sdd /dev/sde -f
t_CheckExitStatus $? 'Fail: Can not create a zpool of raidz3'

zpool destroy tank
