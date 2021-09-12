#!/bin/bash

cat <<_EOF_ >>"${ROOTFS_DIR}"/etc/dhcpcd.conf

interface eth1
static ip_address=192.168.99.1/24
_EOF_

mkdir -p /opt/tftp/netboot

cat <<_EOF_ >"${ROOTFS_DIR}"/etc/dnsmasq.d/machine
# Logging
log-queries
log-facility=/var/log/dnsmasq.log

# Disable DNS, just do DHCP and TFTP
port=53

# Listen for DHCP requests on this interface
interface=eth1

# IP Range
dhcp-range=192.168.99.100,192.168.99.199,12h

# Enable TFTP
enable-tftp
tftp-root=/opt/tftp/netboot
pxe-service=0,"Raspberry Pi Boot"

_EOF_
