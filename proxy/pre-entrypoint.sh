#!/bin/bash

# Check that required environment variables are set
if [ -z "$DOMAIN" ]; then
	echo "DOMAIN is not set"
	exit 1
fi
if [ -z "$CERTBOT_EMAIL" ]; then
	echo "CERTBOT_EMAIL is not set"
	exit 1
fi

# Check that certs are installed
if [ ! -f /etc/letsencrypt/live/${DOMAIN}/fullchain.pem ]; then
	# Use Certbot to install certs with nginx
	certbot --nginx -n --agree-tos --email ${CERTBOT_EMAIL} -d ${DOMAIN}
fi

# Use default entrypoint
/docker-entrypoint.sh "$@"