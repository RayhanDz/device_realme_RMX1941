#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/platform/bootdevice/by-name/recovery:33554432:39a9e850a32a503e0c33594abeebca6a2fb6f377; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/platform/bootdevice/by-name/spmfw:60384:dfc31a9162fc484622b9d19601079eb027c65909 \
          --target EMMC:/dev/block/platform/bootdevice/by-name/recovery:33554432:39a9e850a32a503e0c33594abeebca6a2fb6f377 && \
      log -t recovery "Installing new oppo recovery image: succeeded" && \
      setprop ro.recovery.updated true || \
      log -t recovery "Installing new oppo recovery image: failed" && \
      setprop ro.recovery.updated false
else
  log -t recovery "Recovery image already installed"
  setprop ro.recovery.updated true
fi
