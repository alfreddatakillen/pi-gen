#!/bin/bash

pushd "$(dirname $0)" >/dev/null

if [[ "$(whoami)" != "root" ]]; then
	echo "must be root"
	exit 1
fi

if [ ! -e work ]; then
	mkdir work
	mount -t tmpfs -o size=20G tmpfs work
fi

IMG_NAME="machine" \
	USE_QCOW2="1" \
	RELEASE="bullseye" \
	TARGET_HOSTNAME="machine" \
	FIRST_USER_NAME="user" \
	FIRST_USER_PASS="password" \
	PUBKEY_SSH_FIRST_USER="$(cat /home/user/.ssh/id_rsa.pub)" \
	ENABLE_SSH="1" \
	PUBKEY_ONLY_SSH="1" \
	\
	./build.sh

popd >/dev/null
