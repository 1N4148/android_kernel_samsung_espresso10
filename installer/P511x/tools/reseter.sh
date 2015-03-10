#!/tmp/packing/sbin/busybox sh

## PSN>> AGNi user settings reseter v1.1 (Preserves preloadSWAP indicator)

if [ -f /system/etc/init.d/S72enable_001bkpreloadswap_020-on ];
	then
	/tmp/packing/sbin/busybox mkdir -p /system/etc/init.d/temp
	/tmp/packing/sbin/busybox mv /system/etc/init.d/S72enable_001bkpreloadswap_020-on /system/etc/init.d/temp
fi

/tmp/packing/sbin/busybox rm /system/etc/init.d/*001bk*

if [ -d /system/etc/init.d/temp ];
	then
	/tmp/packing/sbin/busybox mv /system/etc/init.d/temp/S72enable_001bkpreloadswap_020-on /system/etc/init.d
fi

# If old Boeffla apps are installed, remove now
if [ -f /data/app/bo.boeffla-*.apk ] || [ -f /data/app/BoefflaTweaks.apk ]; then
	rm /data/app/bo.boeffla-*.apk
	rm /data/app/BoefflaTweaks.apk
	rm -rf /data/data/*bo.boeffla*
	rm /data/dalvik-cache/*bo.boeffla*
fi;
if [ -f /data/app/bo.boeffla.tweaks.dialog.helper-*.apk ] || [ -f /data/app/BoefflaTweaksDialogHelper.apk ]; then ; then
	rm /data/app/bo.boeffla.tweaks.dialog.helper-*.apk
	rm /data/app/BoefflaTweaksDialogHelper.apk
	rm -rf /data/data/*bo.boeffla.tweaks.dialog.helper*
	rm /data/dalvik-cache/*bo.boeffla.tweaks.dialog.helper*
fi;

chmod 0644 /data/app/AGNi_Control.apk
chmod 0644 /data/app/AGNiControlDialogHelper.apk
chmod 0666 /data/media/0/AGNi_reset_oc-uv_on_boot_failure.zip

