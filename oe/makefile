############################################################################
#
#   Copyright (c) 2015 Mark Charlebois. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. The names of the contributors may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE
# BY THIS LICENSE.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT
# AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED, INCLUDING, 
# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF AND FITNESS FOR A 
# PARTICULAR PURPOSE ARE. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
# EXEMPLARY, OR DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
############################################################################

all: oe

flash0.img: QEMU_EFI.fd
	dd if=/dev/zero of=flash0.img bs=1M count=64
	dd if=QEMU_EFI.fd of=flash0.img conv=notrunc

flash1.img:
	dd if=/dev/zero of=flash1.img bs=1M count=64

QEMU_EFI.fd:
	wget http://snapshots.linaro.org/components/kernel/leg-virt-tianocore-edk2-upstream/159/QEMU-AARCH64/RELEASE_GCC49-ARMBDS/QEMU_EFI.fd

vexpress64-oe.img:
	wget http://releases.linaro.org/14.08/openembedded/aarch64/vexpress64-openembedded_minimal-armv8-gcc-4.9_20140823-686.img.gz
	zcat vexpress64-openembedded_minimal-armv8-gcc-4.9_20140823-686.img.gz > $@

oe: flash0.img flash1.img vexpress64-oe.img
	qemu-system-aarch64 \
	    -m 1024 \
	    -cpu cortex-a57 \
	    -M virt \
	    -pflash flash0.img -pflash flash1.img \
	    -serial stdio \
	    -drive if=none,file=vexpress64-oe.img,id=hd0 \
	    -device virtio-blk-device,drive=hd0

