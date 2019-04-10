# Craft Mac-n-Cheez
Easily create a CraftCMS development environment with Docker. 

Settings remain agnostic after bootstrap completion (i.e. file & folder permissions, credentials, structure). Settings are set by default or customized. For successful operation, it's assumed Docker, Docker Compose and Composer applications are installed. The images [bshelling/craftphpenv](https://cloud.docker.com/u/bshelling/repository/docker/bshelling/craftphpenv) and [mysql:5.7](https://hub.docker.com/_/mysql) are written to the docker-compose.yml.  

### Requirements
[CraftCMS](https://www.craftcms.com)\
[Docker](https://www.docker.com)\
[Docker Compose](https://docs.docker.com/compose)\
[Composer](https://getcomposer.org/)

### Commands
Check for Composer installation
```
$ composer -v
```
Check Docker & Docker Compose installation
```
$ docker -v && docker-compose -v
```
To run application 
```
$ ./craftmacncheez.sh
```

