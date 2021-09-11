#!/bin/bash

# install docker:
curl -sSL https://get.docker.com | sh

# enable docker daemon at boot:
systemctl enable docker

# add our user to the docker group:
usermod -aG docker user

# docker-compose:
apt-get install -y libffi-dev libssl-dev
apt install -y python3-dev
apt-get install -y python3 python3-pip
pip3 install docker-compose

