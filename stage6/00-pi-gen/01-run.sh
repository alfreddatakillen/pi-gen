#!/bin/bash
rsync -a --exclude-from /opt/pi-gen/.gitignore --exclude work --exclude deploy /opt/pi-gen/ "${ROOTFS_DIR}"/opt/pi-gen
