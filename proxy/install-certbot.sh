#!/bin/bash

#Install Snap
apt-get update
apt-get install -y snapd
snap install core
snap refresh core

#Install Certbot
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot