#!/bin/bash -e

function log {
    echo $*
}

CD=$(pwd)
KERNEL_CONFIG=config.gz
export ARCH=arm
export CROSS_COMPILE=$CCPREFIX
export INSTALL_MOD_PATH=$RASPI_BASE/temp/modules

log Check kernel config
if [[ ! -f $KERNEL_CONFIG ]]; then
    echo "Can't find $KERNEL_CONFIG, get it from /proc/config.gz in raspi"
    exit -1
fi

log Clean kernel source
make mrproper -C $KERNEL_SRC

log Decompress kernel config
cat $KERNEL_CONFIG | gzip -d > $KERNEL_SRC/.config

log Make kernel
make -C $KERNEL_SRC

log Install Modules
mkdir -p $INSTALL_MOD_PATH
make -C $KERNEL_SRC modules_install


