DEBUG=True
LOG_LEVEL=DEBUG

# may be uncomment for productive
#DEBUG=0
#FLASK_DEBUG=0

FLASK_APP=run.py

API_HOST_NAME='https://authzprovider-api.com'

DATABASE_URI=mariadb+pymysql:///?user=authzprovider&password=password&database=authzprovider&host=authz-provider-db&charset=utf8mb4
SQLALCHEMY_ECHO=True

PRIVATE_KEY_FILE='/api/var/private_key'
PUBLIC_KEY_FILE='/api/var/public_key'

JWT_ALGO=RS256
JWT_EXP=7200

SERVICE_ACCOUNT_CREDENTIAL_FILE=/api/var/service_account.secret.json

# Without proxy very slow: GOOGLE_API_HOST='https://hub-api.appspot.com'
# GAPI-Proxy direct in docker network: GOOGLE_API_HOST='http://172.17.0.1:5555'
# From network binding see docker-compose.yml
GOOGLE_API_HOST=http://gapi-proxy:5555