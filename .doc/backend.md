## Backend documentation

#### How to install Python related modules in docker container

User ID and Group ID of User on Docker Host via Commands: `$(id -u)` `$(id -g)`

```bash
docker compose up -d 
```

then 

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
