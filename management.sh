#!/bin/bash
echo "--------------------------"
echo "| Welcome to Anime&Manga |"
echo "--------------------------"

#Ask privilege root
if [ "$EUID" -ne 0 ]
then
  echo "Eseguire come root"
  exit 1
fi

# start installation of the script
ENABLE_PROXY=false
FILE_COMPOSE="docker-compose.yml"
SERVICE_POSTGRES=true
SERVICE_MONGO=true
SERVICE_RABBIT=true
SERVICE_PROXY=true
DEFAULT_FOLDER=true

for arg in "$@"
do
    if [ "$arg" == "-h" ]
    then
        echo "Short explane this script of installation: "
        echo "Create default folder for mount point and start docker compose"
        echo ""
        echo "Following commands: "
        echo "dev -> Launch docker compose unstable"
        echo ""
        echo "Manage:"
        echo "down -> stop all services"
        echo ""
        echo "Actions for start:"
        echo "no-default-folder -> No create default folder for volumes"
        echo "no-postgres -> Not start service postgres"
        echo "no-mongo -> Not start service mongo"
        echo "no-rabbit -> Not start service rabbit"
        echo "no-proxy -> Not start service tor proxy"
        exit 1
    fi

    if [ "$arg" == "dev" ]
    then
        FILE_COMPOSE="docker-compose-unstable.yml"
        continue
    fi

    if [ "$arg" == "down" ]
    then
        sudo docker compose -f $FILE_COMPOSE down --timeout 120
        exit 1
    fi

    if [ "$arg" == "no-default-folder" ]
    then
        DEFAULT_FOLDER=false
        continue
    fi

    if [ "$arg" == "no-postgres" ]
    then
        SERVICE_POSTGRES=false
        continue
    fi

    if [ "$arg" == "no-mongo" ]
    then
        SERVICE_MONGO=false
        continue
    fi

    if [ "$arg" == "no-proxy" ]
    then
        SERVICE_PROXY=false
        continue
    fi

    echo "Unknow command: $arg"
    exit 1
done

#change value env of downloadservice
ENV_FILE="./env/download.env"
VAR_TO_CHANGE="PROXY_ENABLE"
NEW_VALUE="$SERVICE_PROXY"

if [ -f "$ENV_FILE" ]; then
    sed -i "s/^$VAR_TO_CHANGE=.*/$VAR_TO_CHANGE=$NEW_VALUE/" "$ENV_FILE"
else
    echo "The file $ENV_FILE not exists."
fi

# check folder
if [ "$DEFAULT_FOLDER" = true ]
then
    if [ ! -d "/animeManga/data" ]
    then
        sudo mkdir -p /animeManga/data
        echo "Created folder: /animeManga/data"
        echo ""
    fi

    if [ ! -d "/animeManga/temp" ]
    then
        sudo mkdir /animeManga/temp
        echo "Created folder: /animeManga/temp"
        echo ""
    fi

    if [ ! -d "/animeManga/dataPostgres" ]
    then
        sudo mkdir /animeManga/dataPostgres
        echo "Created folder: /animeManga/dataPostgres"
        echo ""
    fi

    if [ ! -d "/animeManga/dataMongo" ]
    then
        sudo mkdir /animeManga/dataMongo
        echo "Created folder: /animeManga/dataMongo"
        echo ""
    fi
fi

# start service
sudo docker compose -f $FILE_COMPOSE pull
sudo docker compose -f $FILE_COMPOSE down

COMMAND_COMPOSE="docker compose -f $FILE_COMPOSE up -d"
if [ "$SERVICE_POSTGRES" = false ]
then
    COMMAND_COMPOSE="$COMMAND_COMPOSE --scale postgres=0 "
fi

if [ "$SERVICE_MONGO" = false ]
then
    COMMAND_COMPOSE="$COMMAND_COMPOSE --scale mongo=0 "
fi

if [ "$SERVICE_PROXY" = false ]
then
    COMMAND_COMPOSE="$COMMAND_COMPOSE --scale tor-proxy=0 "
fi

COMMAND_COMPOSE="$COMMAND_COMPOSE"
sudo $COMMAND_COMPOSE
sudo docker image prune