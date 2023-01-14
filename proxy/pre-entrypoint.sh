#!/bin/bash


# Check that required environment variables are set
if [ -z "$DOMAIN" ]; then
	echo "DOMAIN is not set"
	exit 1
fi

# If there is no certificate, generate a self-signed one
if [ ! -f /etc/letsencrypt/live/$DOMAIN/fullchain.pem ]; then
	echo "Generating self-signed certificate"
	mkdir -p /etc/letsencrypt/live/$DOMAIN
	openssl req -x509 -nodes -days 1 -newkey rsa:2048 -keyout /etc/letsencrypt/live/$DOMAIN/privkey.pem -out /etc/letsencrypt/live/$DOMAIN/fullchain.pem -subj "/C=MX/ST=Lazaro Cardenas/L=CDMX/O=SpaceProject/CN=$DOMAIN"
fi
# Do this also for OAUTH_DOMAIN
if [ ! -z "$OAUTH_DOMAIN" ] && [ ! -f /etc/letsencrypt/live/$OAUTH_DOMAIN/fullchain.pem ]; then
	echo "Generating self-signed certificate for $OAUTH_DOMAIN"
	mkdir -p /etc/letsencrypt/live/$OAUTH_DOMAIN
	openssl req -x509 -nodes -days 1 -newkey rsa:2048 -keyout /etc/letsencrypt/live/$OAUTH_DOMAIN/privkey.pem -out /etc/letsencrypt/live/$OAUTH_DOMAIN/fullchain.pem -subj "/C=MX/ST=Lazaro Cardenas/L=CDMX/O=SpaceProject/CN=$OAUTH_DOMAIN"
fi
# Add a job to reload nginx every 6 hours and run crond in the background
crontab -l | { cat; echo "0 */6 * * * nginx -s reload"; } | crontab -
cron &

# Use default entrypoint
/docker-entrypoint.sh "$@"