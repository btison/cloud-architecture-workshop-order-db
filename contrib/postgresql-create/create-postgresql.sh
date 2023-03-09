#!/bin/bash

POSTGRESQL_ADMIN_USER=${POSTGRESQL_ADMIN_USER:-postgres}

MAX_ITERATIONS=${MAX_CONN_ATTEMPTS:-60}

iteration=1

while PGPASSWORD=$POSTGRESQL_ADMIN_PASSWORD pg_isready -U $POSTGRESQL_ADMIN_USER -h $POSTGRESQL_REMOTE_HOST > /dev/null; [[ $? -ne 0 ]];
do
  echo "Postgres database at $POSTGRESQL_REMOTE_HOST is not ready"

  if [[ $iteration -eq $MAX_ITERATIONS ]]
  then
    exit 1
  fi

  sleep 5
  ((iteration++))

done

echo $(pwd)
export SQL_DIR=$(pwd)/sql

envsubst < $SQL_DIR/create.sql > /tmp/create.sql

PGPASSWORD=$POSTGRESQL_ADMIN_PASSWORD createuser -U $POSTGRESQL_ADMIN_USER -h $POSTGRESQL_REMOTE_HOST $POSTGRESQL_USER
PGPASSWORD=$POSTGRESQL_ADMIN_PASSWORD psql --set=username="$POSTGRESQL_USER" --set=password="$POSTGRESQL_PASSWORD" \
  -U $POSTGRESQL_ADMIN_USER -h $POSTGRESQL_REMOTE_HOST <<< "ALTER USER :\"username\" WITH ENCRYPTED PASSWORD :'password';"

PGPASSWORD=$POSTGRESQL_ADMIN_PASSWORD createdb -U $POSTGRESQL_ADMIN_USER -h $POSTGRESQL_REMOTE_HOST \
  --owner="$POSTGRESQL_USER" "$POSTGRESQL_DATABASE"

PGPASSWORD=$POSTGRESQL_ADMIN_PASSWORD psql -U $POSTGRESQL_ADMIN_USER -h $POSTGRESQL_REMOTE_HOST \
  -d $POSTGRESQL_DATABASE -w -c "grant all privileges on database ${POSTGRESQL_DATABASE} to ${POSTGRESQL_USER};"

PGPASSWORD=$POSTGRESQL_ADMIN_PASSWORD psql -U $POSTGRESQL_ADMIN_USER -h $POSTGRESQL_REMOTE_HOST -d $POSTGRESQL_DATABASE \
  -w < /tmp/create.sql