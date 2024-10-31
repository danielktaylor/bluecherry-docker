#!/bin/bash
set -e
set -u
set -o pipefail
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

workingpath=$(pwd)

docker compose pull
docker compose up bc-mysql -d

echo "Sleeping 45 seconds to make sure the database is initialized correctly..."

sleep 45
docker compose stop bc-mysql
docker compose up -d bc-mysql

echo "Sleeping another 15 seconds to run the database creation scripts..."
echo -e "\n\n"

sleep 15
docker compose run bluecherry bc-database-create
docker compose down

sleep 10
docker compose up -d
