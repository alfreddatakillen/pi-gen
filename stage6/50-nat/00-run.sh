#!/bin/bash
cat <<_EOF_ >"${ROOTFS_DIR}"/etc/sysctl.d/wg.conf
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1"
_EOF_
