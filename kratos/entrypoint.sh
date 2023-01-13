#!/bin/bash

if [ -z "$POSTGRES_HOST" ]; then
	echo "POSTGRES_HOST is not set"
	exit 1
fi
if [ -z "$POSTGRES_PORT" ]; then
	echo "POSTGRES_PORT is not set"
	exit 1
fi
if [ -z "$POSTGRES_USER" ]; then
	echo "POSTGRES_USER is not set"
	exit 1
fi
if [ -z "$POSTGRES_PASSWORD" ]; then
	echo "POSTGRES_PASSWORD is not set"
	exit 1
fi
if [ -z "$POSTGRES_DBNAME" ]; then
	echo "POSTGRES_DBNAME is not set"
	exit 1
fi
export PGPASSWORD=$POSTGRES_PASSWORD
echo "All environment variables are set, Starting..."

POSTGRES_UP=`pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER`

if [ $POSTGRES_UP -ne 0 ]; then
	echo "Postgres is not up and running"
	exit 1
fi

if ! psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DBNAME -c '\l' | grep $POSTGRES_DBNAME > /dev/null 2>&1; then
	echo "Database $POSTGRES_DBNAME does not exist, creating it"
	psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -c "CREATE DATABASE $POSTGRES_DBNAME"
fi

if ! psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DBNAME -c 'SHOW password_encryption' | grep scram-sha-256 > /dev/null 2>&1; then
	echo "Database encryption is not scram-sha-256, changing it"
	psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DBNAME -c "ALTER DATABASE $POSTGRES_DBNAME SET password_encryption = 'scram-sha-256'"
	psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DBNAME -c "SELECT pg_reload_conf()"
fi

/env-replace.sh

/home/kratos/bin/kratos -c /home/kratos/config/kratos.yml migrate sql -y postgres://"$POSTGRES_USER":"$POSTGRES_PASSWORD"@"$POSTGRES_HOST":"$POSTGRES_PORT"/"$POSTGRES_DBNAME"?sslmode=disable

exec "$@"