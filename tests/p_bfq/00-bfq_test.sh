
t_Log "$0 - Testing BFQ"

grep bfq /sys/block/sda/queue/scheduler >/dev/null
t_CheckExitStatus $? 'Fail: BFQ scheduler not available'

t_Log "Enabling BFQ"
echo bfq > /sys/block/sda/queue/scheduler
grep '\[bfq\]' /sys/block/sda/queue/scheduler
t_CheckExitStatus $? "Fail: Can not enable BFQ"

t_Log "Testing writes in BFQ enabled disk"
echo 'this is test message' > /root/test_file
t_CheckExitStatus $? "Fail: Can not write to /dev/sda after enabling BFQ"

