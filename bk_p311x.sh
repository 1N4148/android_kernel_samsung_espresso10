#!/bin/sh
export KERNELDIR=`readlink -f .`

mv .git .git-halt

make defconfig cm_espresso_defconfig

. $KERNELDIR/.config

echo "BEGINING KERNEL COMPILATION .........."

cd $KERNELDIR/
make -j4 || exit 1

mkdir -p $KERNELDIR/BUILT_P311x/lib/modules
rm $KERNELDIR/BUILT_P311x/lib/modules/*
rm $KERNELDIR/BUILT_P311x/zImage

echo "BEGINING SGX540 PVR KM COMPILATION ..........."
cd $KERNELDIR/pvr_source/eurasiacon/build/linux2/omap4430_android
make clean
make TARGET_PRODUCT="blaze_tablet" BUILD=release TARGET_SGX=540 PLATFORM_VERSION=4.4.4 || exit
make clean
mv $KERNELDIR/pvr_source/eurasiacon/binary2_540_120_omap4430_android_release/target/*.ko $KERNELDIR/BUILT_P311x/lib/modules/
rm -rf $KERNELDIR/pvr_source/eurasiacon/binary2_540_120_omap4430_android_release

echo "PREPARING BUILT_P311x ..........."
cd $KERNELDIR
find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT_P311x/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT_P311x/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT_P311x/

mv .git-halt .git

echo "COMPILATION TASKS FOR CM P311x COMPLETE !!!!!!!!"
