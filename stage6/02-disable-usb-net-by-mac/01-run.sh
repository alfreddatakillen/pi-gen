#!/bin/bash

# This will disable to udev rule that names network interfaces by mac address:
touch "${ROOTFS_DIR}"/etc/udev/rules.d/73-usb-net-by-mac.rules

