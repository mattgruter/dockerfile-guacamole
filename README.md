# Docker images for Guacamole

<img src="logo.png" align="right">

Run [Guacamole](http://guac-dev.org/), the clientless remote desktop gateway inside Docker containers.

Images on the Docker Hub:

- Daemon: [mattgruter/guacamole-guacd](https://registry.hub.docker.com/u/mattgruter/guacamole-guacd/)
- Database backend: [mattgruter/guacamole-db](https://registry.hub.docker.com/u/mattgruter/guacamole-guacd/)
- Web application: [mattgruter/guacamole-webserver](https://registry.hub.docker.com/u/mattgruter/guacamole-webserver/)


## Getting started
To run the Guacamole daemon, web application and a database backend for authentication do:

    docker run --name guacd mattgruter/guacamole-guacd
    docker run --name db mattgruter/guacamole-db
    docker run --link guacd:guacd --link db:db -p 8080:8080 mattgruter/guacamole-webserver

Now point your browser at [http://localhost:8080](http://localhost:8080).

The default user is `guacadmin` with password `guacadmin`.


## Fig
If you use [fig](http://www.fig.sh/) you can bulid and start all containers with:

    fig up

Or if you don't want to build the images yourself and use the prebuild images from the Docker Hub:

    fig -f fig.prod.yml up

And point your browser at [http://localhost:8080](http://localhost:8080).

The default user is `guacadmin` with password `guacadmin`.


## Daemon
To only run the Guacamole daemon:

    docker run mattgruter/guacamole-guacd

The guacd default port `4822` is exposed by the image.


## Database backend
To only run a Guacamole-ready MariaDB server:

    docker run mattgruter/guacamole-db

The MariaDB server exposes it's default port `3306`.


## Web application
To only run the Guacamole web application:

    docker run -p 8080:8080 guacd mattgruter/guacamole-webserver

The web application expects a running [guacd](https://github.com/mattgruter/dockerfile-guacamole/tree/master/guacd) Guacamole daemon at the address `guacd:4822` and a [Guacamole-ready MySQL database server](https://github.com/mattgruter/dockerfile-guacamole/tree/master/db) at `db:3306`.
You'll probably want to start a guacd and database container first and then link to them as described above.
