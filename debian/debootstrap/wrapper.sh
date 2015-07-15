#!/bin/bash

export TOPDIR=$1
export LINAROIMG=$2

shift
shift

echo "TOPDIR:     ${TOPDIR}"
echo "LINAROIMG:  ${LINAROIMG}"

# create the mount points
mkdir -p debian-iso
mkdir -p debian_root_loop

# mount the Debian ISO
mount -o loop,ro,noexec debian-8.1.0-arm64-netinst.iso debian-iso

# mount the disk image to write to
mount -o loop debian-root debian_root_loop

# Run qemu-debootstrap 
grml-debootstrap --force -v -i ${TOPDIR}/debian-iso --arch arm64 \
	--nokernel --defaultinterfaces --target debian_root_loop \
	-c ./debootstrap/config --packages ./debootstrap/packages 

# Copy the firmware to the Debian image
mkdir -p linaro_root_loop
mount -o loop,ro,noexec ${LINAROIMG}.raw linaro_root_loop
cp -ar linaro_root_loop/lib/firmware/* debian_root_loop/lib/firmware
unmount linaro_root_loop
unmount debian_root_loop
unmount debian-iso
