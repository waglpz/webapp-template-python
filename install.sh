#!/usr/bin/env bash

# Ansi color code variables
R="\e[0;91m"
B="\e[0;94m"
EXPAND_BG="\e[K"
B_BG="\e[0;104m${EXPAND_BG}"
R_BG="\e[0;101m${EXPAND_BG}"
G_BG="\e[0;102m${EXPAND_BG}"
G="\e[0;92m"
W="\e[0;97m"
BOLD="\e[1m"
ULINE="\e[4m"
RST="\e[0m"
CANCEL_PROMT="    press any key to continue or <CTRL+C> to cancel"

clear
echo ""
echo New project initialization...

clear

if  [[ $(docker ps -q) != "" ]]; then
    echo
    echo
    echo -e "All docker services will be down...${RST}"
    read -p "${CANCEL_PROMT}"
    echo
    docker ps -aq | xargs docker stop
    docker ps -aq | xargs docker rm -f
    docker network prune -f
    echo -e "${G}done${RST}"
fi

echo

DB_PORT=
while [[ "${DB_PORT}" = "" ]]; do
  read -p "Please enter the Port for Database service: " -r DB_PORT
  if [[ "${DB_PORT}" -lt 1025 ]]
  then
    DB_PORT=
    echo -e "${R}The port cannot be less than:${RST} 1025"
  fi
done
echo -e "${G}Database server port:${RST} ${DB_PORT}"

API_PORT=
while [[ "${API_PORT}" = "" ]]; do
  read -p "Please enter the Port for Web service: " -r API_PORT
  if [[ "${API_PORT}" -lt 1025 ]]
  then
    API_PORT=
    echo -e "${R}The port cannot be less than:${RST} 1025"
  fi
  if [[ "${API_PORT}" = "${DB_PORT}" ]]
  then
    API_PORT=
    echo -e "${R}The web server port cannot be same as database server port.${RST}"
  fi
done
echo -e "${G}Webserver port:${RST} ${API_PORT}"

read -p "Creating Docker composer environment file .env in project root directory. Press any key to continue..."

printf "UID=%d\nGID=%d\nDB_PORT=%d\nAPI_PORT=%d\nPYTHON_VIRTUAL_ENV=/opt/venv\n" \
"$(id -u)"    \
"$(id -g)"    \
"$DB_PORT"   \
"$API_PORT"  \
> .env

echo -e "${G}Docker composer environment file created with content:${RST}"
cat .env

PROJECT_NAME=$(basename "$PWD")

if [[ ${PROJECT_NAME} -ne 0 ]]
then
  echo  -e "${R}Error occurs at parsing project name string from given: ${PROJECT_NAME}. Exit status: ${EX}.${RST}";
  exit 1;
fi


if [[ -z "${PROJECT_NAME}" ]]
then
  echo -e "${R}Error occurs at parsing project name from given: ${PROJECT_NAME}.${RST}";
  exit 1;
fi

echo ""
echo -e Project name will be: "${G}${PROJECT_NAME}${RST}".
read -p "${CANCEL_PROMT}"

PROJECT_NAME_HUMAN=
while [[ "${PROJECT_NAME_HUMAN}" = "" ]]; do
  read -p "Please enter the Project name for human: " -r PROJECT_NAME_HUMAN
done
echo -e "${G}Project name force humans:${RST} ${PROJECT_NAME_HUMAN}"

VENDOR_NAME=
while [[ "${VENDOR_NAME}" = "" ]]; do
  read -p "Please enter the vendor name: " -r VENDOR_NAME
done
echo -e "${G}Vendor name:${RST} ${VENDOR_NAME}"

MANTAINER_NAME=
while [[ "${MANTAINER_NAME}" = "" ]]; do
  read -p "Please enter the maintainers name: " -r MANTAINER_NAME
done
echo -e "${G}Maintainers name:${RST} ${MANTAINER_NAME}"

MANTAINER_EMAIL=
while [[ "${MANTAINER_EMAIL}" = "" ]]; do
  read -p "Please enter the maintainers email: " -r MANTAINER_EMAIL
done
echo -e "${G}Maintainers email:${RST} ${MANTAINER_EMAIL}"

echo -e "Continue with installation"
read -p "${CANCEL_PROMT}"

find . -type f -exec sed -ri -e 's!@PROJECT_NAME@!'"$PROJECT_NAME"'!g' "{}" \;
find . -type f -exec sed -ri -e 's!@PROJECT_NAME_HUMAN@!'"$PROJECT_NAME_HUMAN"'!g' "{}" \;
find . -type f -exec sed -ri -e 's!@VENDOR_NAME@!'"$VENDOR_NAME"'!g' "{}" \;
find . -type f -exec sed -ri -e 's!@MANTAINER_NAME@!'"$MANTAINER_NAME"'!g' "{}" \;
find . -type f -exec sed -ri -e 's!@MANTAINER_EMAIL@!'"$MANTAINER_EMAIL"'!g' "{}" \;

touch api/.flaskenv

echo ""
read -p "Press any key for continue with building docker images"

docker compose build --force-rm --no-cache --pull
echo -e "${G}Finish build images${RST}"
docker images | grep "$(basename $PWD)"

read -p "Enable names to IP mapping in /etc/hosts"
sudo su -c 'echo "## '"${NAME}"'" >> /etc/hosts && cat docker-compose.yml | grep "/etc/hosts" -A 15 | grep -v "/etc/hosts" | awk "NF" | sed -e "s/# //" >> /etc/hosts'

tail -n15 /etc/hosts
rm -rv bin

echo ""
read -p "Press any key for continue with sync the Python virtual environment"

bash api/bin/venv-sync.sh

echo -e "${G_BG}${G}All is done. Finite ;)${RST}"