# Docker images for Guacamole, the HTML5 Clientless Remote Desktop

Run [Guacamole](http://guac-dev.org/) inside Docker containers.

Link:
- [mattgruter/guacamole-guacd](https://registry.hub.docker.com/u/mattgruter/guacamole-guacd/)
- [mattgruter/guacamole-db](https://registry.hub.docker.com/u/mattgruter/guacamole-guacd/)
- [mattgruter/guacamole-webserver](https://registry.hub.docker.com/u/mattgruter/guacamole-guacd/)


## Ports
The web server is accessible through port `8080`.

## Run
To run the Guacamole server, client (webserver) and a MySQL backend for authentication do:

    docker run --name guacd mattgruter/guacamole-guacd
    docker run --name db mattgruter/guacamole-db
    docker run --link guacd:guacd --link db:db -p 8080:8080 mattgruter/guacamole-webserver

Now point your browser to http://localhost:8080

## Fig
Download the fig.yml file in this repo and do:

    fig up
    