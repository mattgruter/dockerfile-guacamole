# Docker images for Guacamole

## Quick Start

    docker run --name guacd  mattgruter/guacamole-guacd
    docker run --name guacdb mattgruter/guacamole-db
    docker run --link guacd:guacd --link guacdb:db -p 8080:8080 mattgruter/guacamole-webserver

Now point your browser to http://localhost:8080


## TODO
* Slimmer guacd image (remove build tools and dev header libs)
* Create fig config

