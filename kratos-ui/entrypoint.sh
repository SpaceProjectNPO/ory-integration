#!/bin/bash

if [ -z "$KRATOS_PUBLIC_URL" ]; then
	echo "KRATOS_PUBLIC_URL is not set"
	exit 1
fi
if [ -z "$KRATOS_BROWSER_URL" ]; then
	echo "KRATOS_BROWSER_URL is not set"
	exit 1
fi

echo "All environment variables are set, Starting..."

exec "$@"