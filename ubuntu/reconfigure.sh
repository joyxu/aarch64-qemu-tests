#!/bin/bash
#
# This script is run as root from within the chroot
#

dpkg -P cloud-guest-utils cloud-init pollinate landscape-client landscape-common apparmor apport apport-symptoms ufw
rm -f /etc/init/pollinate.conf /etc/default/pollinate
rm -rf /etc/cloud
perl -p -i -e 's/modprobe -q -b vesafb/true/g;' /etc/init/udev-fallback-graphics.conf
perl -p -i -e 's/^PermitRootLogin.+$/PermitRootLogin yes/g;' /etc/ssh/sshd_config
perl -p -i -e 's/^PasswordAuthentication.+$/PasswordAuthentication yes/g;' /etc/ssh/sshd_config
rm -f /etc/ssh/ssh_host_*_key*
dpkg-reconfigure openssh-server
dpkg-reconfigure tzdata
adduser ubuntu
usermod -aG adm ubuntu
usermod -aG sudo ubuntu
perl -p -i -e 's/^NTPDATE_USE_NTP_CONF=.+$/NTPDATE_USE_NTP_CONF=no/g;' /etc/default/ntpdate
echo "newhost" >/etc/hostname
echo "Set the root password:"
passwd
sync
