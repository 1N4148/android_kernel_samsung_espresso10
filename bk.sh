#!/bin/sh
export KERNELDIR=`readlink -f .`

cd $KERNELDIR;

echo "Building P311x .....";
./bk_p311x.sh && sleep 10

echo "Building P511x .....";
./bk_p511x.sh && sleep 10


