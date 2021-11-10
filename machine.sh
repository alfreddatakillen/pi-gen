#!/bin/bash

pushd "$(dirname $0)" >/dev/null

if [[ "$(whoami)" != "root" ]]; then
	echo "must be root"
	exit 1
fi

IMG_NAME="machine" \
	USE_QCOW2="1" \
	RELEASE="buster" \
	TARGET_HOSTNAME="machine" \
	FIRST_USER_NAME="user" \
	FIRST_USER_PASS="password" \
	PUBKEY_SSH_FIRST_USER="$(curl https://github.com/alfreddatakillen.keys)" \
	ENABLE_SSH="1" \
	PUBKEY_ONLY_SSH="1" \
	STAGE_LIST="stage0 stage1 stage2 stage6 stage99" \
	\
	./build.sh

popd >/dev/null
