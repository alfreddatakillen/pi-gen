#!/bin/bash

mkdir "${ROOTFS_DIR}"/etc/wireguard
chmod 700 "${ROOTFS_DIR}"/etc/wireguard
cp /etc/wireguard/wg0.conf "${ROOTFS_DIR}"/etc/wireguard/wg0.conf
chmod 600 "${ROOTFS_DIR}"/etc/wireguard/wg0.conf

