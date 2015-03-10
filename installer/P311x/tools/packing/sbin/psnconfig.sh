#!/sbin/busybox sh

#### PSN>> pureCM configurator

# setting up swappiness
echo 30 > /proc/sys/vm/swappiness

# LMK minfree
echo "12288,15360,18432,21504,24576,30720" > /sys/module/lowmemorykiller/parameters/minfree

#Misc
echo 0 >  /sys/devices/system/cpu/sched_mc_power_savings
echo 0 > /sys/kernel/dyn_fsync/Dyn_fsync_earlysuspend
echo 0 > /sys/kernel/dyn_fsync/Dyn_fsync_active

# PSN>> ZRAM activator 200 MB
#Zram0
swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
echo 209715200 > /sys/block/zram0/disksize
echo 1 > /sys/block/zram0/initstate
mkswap /dev/block/zram0
swapon -p 2 /dev/block/zram0

#### EFS backup
if [ ! -f /data/.AGNi/efsbackup.tar.gz ];
then
  mkdir /data/.AGNi
  mkdir /data/media/0/AGNi_efs_backup
  chmod 777 /data/.AGNi
  /sbin/busybox tar zcvf /data/.AGNi/efsbackup.tar.gz /efs
  /sbin/busybox cat /dev/block/platform/omap/omap_hsmmc.1/by-name/EFS > /data/.AGNi/efsdev-EFS.img
  /sbin/busybox gzip /data/.AGNi/efsdev-EFS.img
  /sbin/busybox cp /data/.AGNi/* /data/media/0/AGNi_efs_backup/
  chmod 777 /data/media/0/AGNi_efs_backup/efsdev-EFS.img
  chmod 777 /data/media/0/AGNi_efs_backup/efsbackup.tar.gz
fi

### SETTING CPU UV AND GPU OC permissions
chown system system /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table
chmod 0660 /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table
chown system system /sys/devices/system/cpu/cpu0/cpufreq/gpu_oc
chmod 0660 /sys/devices/system/cpu/cpu0/cpufreq/gpu_oc

chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1008000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 0444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq
echo 180000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

#setting cfq internal sd
chmod 0664 /sys/block/mmcblk0/queue/scheduler
echo "cfq" > /sys/block/mmcblk0/queue/scheduler
chmod 0444 /sys/block/mmcblk0/queue/scheduler

