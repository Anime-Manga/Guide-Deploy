#!/bin/bash
echo "--------------------------"
echo "| Welcome to Anime&Manga |"
echo "--------------------------"

sudo mkdir /animeManga mkdir /animeManga/data /animeManga/temp /animeManga/dataPostgres /animeManga/dataMongo

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