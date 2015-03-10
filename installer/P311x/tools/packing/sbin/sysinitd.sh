#!/sbin/sh

while ! /sbin/busybox pgrep android.process.acore ; do
  /sbin/busybox sleep 1
done

## Set optimum permissions for init.d scripts
/sbin/busybox sh /sbin/sysrw
/sbin/busybox sh /sbin/rootrw

chmod -R 777 /system/etc/init.d

## Setting profiles scripts as non-executable
/sbin/busybox chmod 0644 /system/etc/init.d/S46enable_001bkprofiles_*
/sbin/busybox rm /system/etc/init.d/S35enable_001bkusbumsmode_002-on

/sbin/busybox sh /sbin/frandom.sh

/sbin/busybox sh /sbin/sysro
/sbin/busybox sh /sbin/rootro

# AGNi sdcard1<-->sdcard0 Switcher
if [ -f /system/etc/init.d/S81enable_001bkextsd2intsd_020-on ];
	then
	/sbin/busybox sh /sbin/agni_storage_switcher.sh
fi

# Configuration app support
if [ ! -f /data/app/hm.agni-*.apk ] || [ ! -f /data/app/AGNi_Control.apk ];
	then
	cp /res/app/AGNi_Control.apk /data/media/0
	chmod 777 /data/media/0/AGNi_Control.apk
	/system/bin/pm install -r /data/media/0/AGNi_Control.apk
	rm /data/media/0/AGNi_Control.apk
fi
if ! [ -f /data/app/hm.agni.control.dialog.helper-*.apk ] || [ ! -f /data/app/AGNiControlDialogHelper.apk ];
	then
	cp /res/app/AGNiControlDialogHelper.apk /data/media/0
	chmod 777 /data/media/0/AGNiControlDialogHelper.apk
	/system/bin/pm install -r /data/media/0/AGNiControlDialogHelper.apk
	rm /data/media/0/AGNiControlDialogHelper.apk
fi

# AGNi reseter
if [ -d "/data/media/0" ] && [ ! -f $AGNi_RESETER_CM ] ; then
	cp /res/reseter/AGNi_reset_oc-uv_on_boot_failure.zip $AGNi_RESETER_CM
	chmod 775 $AGNi_RESETER_CM
fi

chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1008000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 0444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 180000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

## Executing init.d scripts
export PATH=/sbin:/system/sbin:/system/bin:/system/xbin
/system/bin/logwrapper /sbin/busybox run-parts /system/etc/init.d

