## App deployment

* [Web](../web.md)
* [API](../api.md) 
* [Database](../db.md)
* [Development](../development)
* [Deployment](../deployment/production.md)
* [Docker](../docker.md)

#### After first install on production server
 
Copy api/.env.dist into api/.env and set necessary values eg credentials to database

#### Relaunch operations
Steps witch is needed to relaunch new version are:
1. Login to production server. Current server *web06* 
1. Go into directory where is @PROJECT_NAME_HUMAN@ is installed. Currently: `/dataserver/webserver/@PROJECT_NAME@.@VENDOR_NAME@-wasser.de`
1. Fetch new stuf from Gitlab `git fetch origin <branch-or-tag-name>`
1. Checkout `git reset --hard origin/<branch-name>`
1. Install new Python packages if this needed. Command  `pipenv install`
1. Restring @PROJECT_NAME@ service `sudo systemctl restart @PROJECT_NAME@`
1. Run migrations: `PYTHONPATH=/dataserver/webserver/@PROJECT_NAME@.@VENDOR_NAME@-wasser.de/api flask db upgrade`
1. Such output via `tail -f /var/log/syslog` is to expected. You must get root user rights ie sudo
```
Apr 14 09:33:48 web06 gunicorn[450472]: [2023-04-14 09:33:48 +0000] [450472] [INFO] Starting gunicorn 20.1.0
Apr 14 09:33:48 web06 gunicorn[450472]: [2023-04-14 09:33:48 +0000] [450472] [DEBUG] Arbiter booted
Apr 14 09:33:48 web06 gunicorn[450472]: [2023-04-14 09:33:48 +0000] [450472] [INFO] Listening at: unix:/run/@PROJECT_NAME@.sock (450472)
Apr 14 09:33:48 web06 gunicorn[450472]: [2023-04-14 09:33:48 +0000] [450472] [INFO] Using worker: sync
Apr 14 09:33:48 web06 systemd[1]: Started @PROJECT_NAME@ gunicorn daemon.

```
1. 