# Docker images for Guacamole

## Quick Start

    docker run --name guacd                    mattgruter/guacamole-guacd
    docker run --link guacd:guacd -p 8080:8080 mattgruter/guacamole-webserver

Now point your browser to http://localhost:8080


## TODO
* Add auth via MySQL
* Slimmer guacd image (remove build tools and dev header libs)
* Create fig config

