#!/bin/bash -e
install -d "${ROOTFS_DIR}/etc/systemd/system/enable-overlayfs.target.wants"
install -m 644 files/enable-overlayfs.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/enable-overlayfs.target "${ROOTFS_DIR}/etc/systemd/system/"
install -m 755 files/enable_overlayfs.sh "${ROOTFS_DIR}/usr/bin/"

on_chroot << EOF
ln -sf /etc/systemd/system/enable-overlayfs.service /etc/systemd/system/enable-overlayfs.target.wants/enable-overlayfs.service
systemctl daemon-reload
systemctl set-default enable-overlayfs.target
EOF
