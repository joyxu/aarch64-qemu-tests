#!/bin/bash
#
# This script is run with sudo

USERNAME=$1

# mount the disk image
modprobe nbd max_part=8
qemu-nbd --connect=/dev/nbd0 vivid-server-cloudimg-arm64-disk1.img
mount /dev/nbd0p1 ./virt

# Extract the boot files
cp ./virt/boot/*-generic boot
chown $USERNAME:$USERNAME boot/*


# Add the reconfiguration script
cp reconfigure.sh ./virt/
chmod +x ./virt/reconfigure.sh

# Enable QEMU user emulation for AArch64 in chroot
cp /usr/bin/qemu-aarch64-static ./virt/usr/bin/

# Reconfigure the rootfs (remove packages, set TZ, add user, etc)
chroot ./virt /reconfigure.sh

# Cleanup
umount ./virt
qemu-nbd -d /dev/nbd0
