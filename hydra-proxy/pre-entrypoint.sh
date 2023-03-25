#!/bin/bash


if [ ! -z "$OAUTH_DOMAIN" ] && [ ! -f /etc/letsencrypt/live/$OAUTH_DOMAIN/fullchain.pem ]; then
	echo "Generating self-signed certificate for $OAUTH_DOMAIN"
	mkdir -p /etc/letsencrypt/live/$OAUTH_DOMAIN
	openssl req -x509 -nodes -days 1 -newkey rsa:2048 -keyout /etc/letsencrypt/live/$OAUTH_DOMAIN/privkey.pem -out /etc/letsencrypt/live/$OAUTH_DOMAIN/fullchain.pem -subj "/C=MX/ST=Lazaro Cardenas/L=CDMX/O=SpaceProject/CN=$OAUTH_DOMAIN"
fi

# Use default entrypoint
/docker-entrypoint.sh "$@"