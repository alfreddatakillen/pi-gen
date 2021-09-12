#!/bin/bash

# Trying to fix broken install
apt remove -y qemu-user-static
apt install -y qemu-user-static
