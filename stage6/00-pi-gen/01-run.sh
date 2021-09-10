#!/bin/bash
rsync -a --exclude deploy --exclude work /opt/pi-gen/ "${ROOTFS_DIR}"/opt/pi-gen
