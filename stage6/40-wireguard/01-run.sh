#!/bin/bash

cp /etc/wireguard/wg-vpn.conf "${ROOTFS_DIR}"/etc/wireguard/wg-vpn.conf
chmod 600 "${ROOTFS_DIR}"/etc/wireguard/wg-vpn.conf

