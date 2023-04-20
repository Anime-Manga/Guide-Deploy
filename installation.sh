#!/bin/bash
sudo mkdir /data /temp /dataPostgres /dataMongo

if [[ $1 == "dev" ]]
then
    FILE_COMPOSE="docker-compose-unstable.yml"
else
    FILE_COMPOSE="docker-compose.yml"
fi

sudo docker compose -f $FILE_COMPOSE pull
sudo docker compose -f $FILE_COMPOSE down
sudo docker compose -f $FILE_COMPOSE up -d
sudo docker image prune