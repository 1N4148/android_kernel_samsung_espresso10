#!/sbin/busybox sh

chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1008000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 0444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq
echo 1008000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

