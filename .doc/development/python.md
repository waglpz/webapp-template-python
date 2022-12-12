#### How to install Python virtual environment on host for IDE

* [Web](../web.md)
* [API](../api.md) 
* [Database](../db.md)
* [Development](../development)
* [Deployment](../deployment/production.md)
* [Docker](../docker.md)

After docker compose is starting run script `bash api/bin/venv-sync.sh` 
this one copied the content of venv folder from backend container into locale directory 
under api, then can be enabled in the IDE  


#### How to install Python related modules in docker container

Start container
```bash
docker compose up -d 
```
then logg in the api container
###### Get user ID / group ID which is works on host machine: `$(id -u)` `$(id -g)`
```bash
docker compose exec -u $(id -u):$(id -g) api bash
```

#### Show possible Commands of pipenv 
```bash
devguy@#########:/app$ pipenv --help
```

#### Install Python Module (example) 
```bash
devguy@#########:/api$ pipenv install flask
devguy@#########:/api$ pipenv install flask-migrate
```

#### Show Flask available Commands 
```bash
devguy@#########:/api$ flask --help
```