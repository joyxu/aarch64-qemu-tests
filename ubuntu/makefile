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

all: ubuntu-cloud

vivid-server-cloudimg-arm64-disk1.img:
	wget https://cloud-images.ubuntu.com/vivid/current/vivid-server-cloudimg-arm64-disk1.img

disk1.img: vivid-server-cloudimg-arm64-disk1.img
	ln -s *disk1.img disk1.img

boot/vmlinuz: vivid-server-cloudimg-arm64-disk1.img
	sudo modprobe nbd max_part=8
	sudo qemu-nbd --connect=/dev/nbd0 vivid-server-cloudimg-arm64-disk1.img
	mkdir -p ./virt 
	sudo mount /dev/nbd0p1 ./virt
	mkdir -p boot && rm -f ./boot/*
	sudo cp ./virt/boot/*-generic boot
	sudo chown $(USER):$(USER) boot/*
	sudo qemu-nbd -d /dev/nbd0
	sudo umount ./virt
	cd boot && ln -s initrd.img-* initrd.img
	cd boot && ln -s vmlinuz-* vmlinuz

ubuntu-cloud: disk1.img boot/vmlinuz
	qemu-system-aarch64 \
		-m 1024 \
		-cpu cortex-a57 -smp 1 \
    		-M virt -nographic \
    		-rtc driftfix=slew -kernel boot/vmlinuz \
    		-append "console=ttyAMA0 root=LABEL=cloudimg-rootfs rw init=/bin/sh" \
    		-initrd boot/initrd.img -device virtio-scsi-device,id=scsi \
    		-device scsi-hd,drive=hd -drive if=none,id=hd,file=disk1.img
