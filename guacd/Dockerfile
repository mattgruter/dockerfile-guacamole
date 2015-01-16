FROM debian:jessie
MAINTAINER Matthias Grüter <matthias@grueter.name>

# To update, check http://guac-dev.org/releases
ENV GUACAMOLE_VERSION 0.9.4
ENV GUACAMOLE_SERVER_SHA1 feafdb0714feac9494e3f53a5e3a590fe3d98513


ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y gcc make && \
    apt-get install -y libcairo2-dev libpng12-dev libossp-uuid-dev libvncserver-dev libfreerdp-dev libssl-dev && \
    apt-get clean


RUN echo $GUACAMOLE_SERVER_SHA1  guacamole-server.tar.gz > guacamole-server.tar.gz.sha1 && \
    curl -L -o guacamole-server.tar.gz http://sourceforge.net/projects/guacamole/files/current/source/guacamole-server-${GUACAMOLE_VERSION}.tar.gz/download && \
    sha1sum -c --quiet guacamole-server.tar.gz.sha1 && \
    tar xzf guacamole-server.tar.gz && \
    rm guacamole-server.tar.gz*
RUN cd guacamole-server-${GUACAMOLE_VERSION} && \
    ./configure && \
    make install && \
    ldconfig
# TODO: remove build tools and libs after installation


ENV GUACAMOLE_HOME /guacd
RUN mkdir -p /guacd
WORKDIR /guacd
EXPOSE 4822

CMD ["guacd", "-f", "-b", "0.0.0.0", "-l", "4822"]