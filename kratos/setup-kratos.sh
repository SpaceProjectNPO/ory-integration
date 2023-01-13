#!/bin/bash

# Install latest ory-kratos release
cd /home/kratos/bin
wget https://github.com/ory/kratos/releases/download/v0.11.0/kratos_0.11.0-linux_64bit.tar.gz
tar -xvf kratos_0.11.0-linux_64bit.tar.gz
rm kratos_0.11.0-linux_64bit.tar.gz
rm *md
rm LICENSE
# Get config files
cd ../config
wget https://raw.githubusercontent.com/ory/kratos/v0.11.0/contrib/quickstart/kratos/email-password/identity.schema.json
wget https://raw.githubusercontent.com/ory/kratos/v0.11.0/contrib/quickstart/kratos/email-password/kratos.yml

# Change default location of identity schema
sed -i 's|file:///etc/config/kratos/identity.schema.json|file:///home/kratos/config/identity.schema.json|g' kratos.yml
# Disable logging of sentitive values
sed -i 's|log_sensitive_values: true|log_sensitive_values: false|g' kratos.yml