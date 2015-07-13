##############################################################################
#	
# Copyright (c) 2015 Mark Charlebois (charlebm@gmail.com)
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted (subject to the limitations in the
# disclaimer below) provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the
#   distribution.
#
# NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE
# GRANTED BY THIS LICENSE.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT
# HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##############################################################################

#
# Build and run an AArch64 buildroot created initrd, in QEMU
#
# root password is root
#

TOPDIR:=`pwd`
CPIO:=$(TOPDIR)/buildroot.git/output/images/rootfs.cpio
GCCVER:=gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux
GCCDIR:=$(TOPDIR)/$(GCCVER)/bin
GCCBINDIR:=$(GCCDIR)/bin

all: run

# Get buildroot
buildroot.git:
	git clone git://git.buildroot.net/buildroot $@

# Get Linaro AArch64 cross compiler
$(GCCDIR):
	wget http://releases.linaro.org/14.09/components/toolchain/binaries/$(GCCVER).tar.xz
	tar xJf $(GCCVER).tar.xz

# Make the initramfs
$(CPIO): buildroot.git $(GCCVER) buildroot_config
	cp buildroot_config buildroot.git/.config
	sed -i "s#BR2_TOOLCHAIN_EXTERNAL_PATH=.*#BR2_TOOLCHAIN_EXTERNAL_PATH=\"$(GCCDIR)\"#" buildroot.git/.config
	(cd buildroot.git && make oldconfig && make)

# Get AArch64 linux kernel tree
linux:
	git clone git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git linux

# Make the kernel, substutute path to cpio
linux/arch/arm64/boot/Image: linux $(CPIO) kernel_config
	cp kernel_config linux/.config
	sed -i "s#CONFIG_INITRAMFS_SOURCE=.*#CONFIG_INITRAMFS_SOURCE=\"$(CPIO)\"#" linux/.config
	(cd linux && ARCH=arm64 make oldconfig)
	(cd linux && ARCH=arm64 make)

# Run the kernel and initrd in QEMU
run: linux/arch/arm64/boot/Image 
	which qemu-system-aarch64 || (echo "Error: Install qemu-system-aarch64" && false)
	qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -smp 1 -m 2048 -kernel linux/arch/arm64/boot/Image --append "console=ttyAMA0"

