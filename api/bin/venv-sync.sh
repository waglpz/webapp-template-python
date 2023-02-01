#!/usr/bin/env bash

# Info: this script helps to install or remove Python virtual environment
# installiert in Docker container and synchronizing with the host maschine

# Attention: do sync venv with host only if the file system/os arch is same as in Docker container

id="@PROJECT_NAME@-api"

if [[ "$1" == 'rm' ]]
then
  echo Remove Python venv...
  for c in $(docker ps -a | grep ${id} | awk '{print $1}')
  do
    echo Stop and remove container: $c
    docker stop $c
    docker rm $c
  done

  echo Delete api/venv
  rm -rf api/venv

  if [[ $(docker volume ls | grep "${id}-venv") ]]
  then
    echo "Delete volume: ${id}-venv"
    docker volume rm "${id}-venv"
    echo Docker volumes left:
    echo "\t" $(docker volume ls)
  fi

  echo Removing venv is done.
  exit
fi

docker compose stop api

docker compose run -u $(id -u):$(id -g) api bash .docker/pipenv-install.sh

docker compose up -d api

docker cp ${id}:/opt/venv api/venv

docker compose down

echo Python Venv was synced
echo   to remove them run: bash $0 rm
echo
