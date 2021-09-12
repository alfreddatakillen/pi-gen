#!/bin/bash
/usr/bin/raspi-config nonint do_overlayfs 0
systemctl set-default multi-user.target
reboot
