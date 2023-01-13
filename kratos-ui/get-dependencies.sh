#!/bin/bash

apt-get update -y && apt upgrade -y
apt-get install wget curl git tar unzip jq -y
# Clear apt cache
apt-get clean
