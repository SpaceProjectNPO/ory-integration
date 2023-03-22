#!/bin/bash

# Install Node.js 16
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get update -y
apt-get install -y nodejs

# Clear apt cache
apt-get clean