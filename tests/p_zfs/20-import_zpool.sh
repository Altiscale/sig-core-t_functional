t_Log "Running $0 - Import zpool test"

zpool create tank raidz3 /dev/sdb /dev/sdc /dev/sdd /dev/sde -f
echo 'test message for import test' > /tank/import_test
zpool destroy tank

zpool import -D tank >/dev/null
t_CheckExitStatus $? 'Fail: Can not import zpool'

grep 'test message for import test' /tank/import_test >/dev/null
t_CheckExitStatus $? 'Fail: Can not fetch data from imported zpool'

zpool destroy tank
