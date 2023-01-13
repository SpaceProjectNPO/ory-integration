#!/bin/bash

# Install latest ory-kratos-ui release
useradd -s /bin/false -m -d /opt/uinode uinode
cd /opt/uinode
wget https://github.com/ory/kratos-selfservice-ui-node/archive/refs/tags/v0.11.0.zip
unzip v0.11.0.zip
rm  v0.11.0.zip
mv kratos-selfservice-ui-node-0.11.0/ ui
cd ui
npm i
chown -R uinode /opt/uinode