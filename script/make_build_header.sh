#!/bin/bash -e

function log {
    echo $*
}

KERNEL_CONFIG=config.gz
INSTALL_MOD_PATH=$RASPI_BASE/temp/modules

log Check kernel config
if [[ ! -f $KERNEL_CONFIG ]]; then
    echo "Can't find $KERNEL_CONFIG, get it from /proc/config.gz in raspi"
    exit -1
fi

log Clean kernel source
make mrproper -C $KERNEL_SRC

log Decompress kernel config
cat $KERNEL_CONFIG | gzip -d > $KERNEL_SRC/.config

#log Prime kernel with old config
#make -C $KERNEL_SRC oldconfig

log Prepare for modules compilation
#make -C $KERNEL_SRC prepare
#make -C $KERNEL_SRC scripts
#make -C $KERNEL_SRC modules_prepare
make -C $KERNEL_SRC 
exit 0

log Make kernel
make -C $KERNEL_SRC

if [[ $1 -eq "install "]]; then
	log Install Modules
	mkdir -p $INSTALL_MOD_PATH
	make -C $KERNEL_SRC modules_install
fi


