## API documentation

* [Web](web.md)
* [API](api.md) 
* [Database](db.md)
* [Development](development)
* [Deployment](deployment/production.md)
* [Docker](docker.md)

### Setup api
In the folder of your choice, enter the following commands:

#### Clone the Repository local:
`git clone git@gitlab.com:@VENDOR_NAME@.com/germany/wasser-deutschland-gmbh/allgemein/@PROJECT_NAME@.git`

#### Open Project directory:
`cd @PROJECT_NAME@`

#### Create `.env` file for docker compose:
`bash -c "$(cat .doc/docker.md | grep printf)"`

#### Test success creation:
```bash
cat .env
# your should see such output:
UID=1000
GID=1000
DB_PORT=3367
API_PORT=8081
PYTHON_VIRTUAL_ENV=/opt/venv
```
#### Bild Docker Images
`bash -c "$(cat .doc/docker.md | grep 'docker compose build')"`

wait please until all related images are downloaded and compiled
                                                              
#### Add mapping for hosts of @PROJECT_NAME@ app  
`sudo su -c 'echo "## @PROJECT_NAME@ APP" >> /etc/hosts && cat docker-compose.yml | grep "/etc/hosts" -A 15 | grep -v "/etc/hosts" | awk "NF" | sed -e "s/# //" >> /etc/hosts'`

or setup necessary mapping manually, show info in `docker-composer.yml` at file bottom

#### Install Python virtual environment and sync this one with the host
`bash api/bin/venv-sync.sh`

wait until the execution is finished

###### if you will roll back and unsync venv then run: bash api/bin/venv-sync.sh rm  
 
#### Stat @PROJECT_NAME@ app
`docker compose up -d`

###### check all docker services are up

`docker compose ps`

#### Manage API from container
logg into api container
`docker compose exec -u $(id -u):$(id -g) api bash`

###### To manage API via flask CLI you can display list of existing commands

`flask --help`

###### Migrate database schema to the HEAD
apply all existing migrations to database

`flask db upgrade`

###### Create (seed) users and admins

`flask user:create`

###### Create (seed) webapps

`flask webapp:create`

###### Attach webapps to users

`flask user:add:webapp`

#### Api Specification as Open API via Swagger
open in browser: https://@PROJECT_NAME@-api.com/api/doc 
your see s swagger @PROJECT_NAME@ API documentation page

#### Show logs from api docker container
`docker compose logs --tail 20 -f api`
