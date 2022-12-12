## Web (frontend) documentation

* [Web](web.md)
* [API](api.md) 
* [Database](db.md)
* [Development](development)
* [Deployment](deployment/production.md)
* [Docker](docker.md)

Setup web

*note:* API backend and Docker compose should be already setup and started. See api setup [API](api.md) 

#### Install dependencies in web container 
log into web container
`docker compose exec -u $(id -u):$(id -g) web bash`
then run:
`node@*******:/web$ npn install`
wait until installation routine is completed.

#### Starting web (with hot reload)
log into web container
`docker compose exec -u $(id -u):$(id -g) web bash`
then run:
`node@*******:/web$ npn run start`
output you must see:
```
Compiled successfully!

You can now view portal-web in the browser.

  Local:            https://localhost:3000
  On Your Network:  https://10.120.10.4:3000

Note that the development build is not optimized.
To create a production build, use npm run build.

webpack compiled successfully

```


#### Build web in dist for deployment
log into web container
`docker compose exec -u $(id -u):$(id -g) web bash`
then run:
`node@*******:/web$ npn run build`
wait until build routine is completed.



