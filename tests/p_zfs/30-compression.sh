t_Log "Running $0 - Compression test"

zpool create tank sdb sdc sdd sde -f

compression_types=( lzjb lz4 gzip zle gzip-1 gzip-9 )

for type in "${compression_types[@]}"
do
  t_Log "Setting compression for tank/$type"
	zfs create tank/$type
  zfs set compression=$type tank/$type;
  curl -so /tank/$type/README 'https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.4.6' || t_CheckExitStatus $? "Fail: Can not write to FS /tank/$type"
done

for type in "${compression_types[@]}"
do
  [ `zfs get compression tank/$type | tail -1 | awk '{print $3}'` = "$type" ] || t_CheckExitStatus $? "Fail: Something wrong with $type compression"
done
t_CheckExitStatus $?
