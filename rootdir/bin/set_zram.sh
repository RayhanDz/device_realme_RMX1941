#! /vendor/bin/sh

# Setup ZRAM Based On Available Ram
MemTotalStr=`cat /proc/meminfo | grep MemTotal`
MemTotal=${MemTotalStr:16:8}
echo 1 > /sys/block/zram0/reset
echo 'lz4' > /sys/block/zram0/comp_algorithm
sleep 0.5

#config 2GB zram size with memory less or equals to 4 GB
echo 2147483648 > /sys/block/zram0/disksize
echo 160 > /proc/sys/vm/swappiness
echo 60 > /proc/sys/vm/direct_swappiness

sleep 0.5
mkswap /dev/block/zram0
sleep 0.5
swapon -d /dev/block/zram0
