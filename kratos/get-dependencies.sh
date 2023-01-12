#!/bin/bash

apt-get update -y && apt upgrade -y
apt-get install wget curl git tar unzip jq -y
apt-get install postgresql-client -y
# Clear apt cache
apt-get clean
