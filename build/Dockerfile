FROM debian:jessie

MAINTAINER Matthias Grüter <matthias@grueter.name>

ENV GUACAMOLE_VERSION 0.9.4

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y libcairo2-dev libpng12-dev libossp-uuid-dev libvncserver-dev
RUN apt-get clean

ENV GUACAMOLE_SERVER_SHA1 feafdb0714feac9494e3f53a5e3a590fe3d98513
RUN apt-get install -y curl

RUN echo $GUACAMOLE_SERVER_SHA1  guacamole-server.tar.gz > guacamole-server.tar.gz.sha1
RUN curl -L -o guacamole-server.tar.gz http://sourceforge.net/projects/guacamole/files/current/source/guacamole-server-${GUACAMOLE_VERSION}.tar.gz/download
RUN sha1sum -c guacamole-server.tar.gz.sha1
RUN tar xzf guacamole-server.tar.gz
RUN rm guacamole-server.tar.gz


RUN apt-get install -y gcc
#ADD https://github.com/glyptodon/guacamole-server/archive/${GUACAMOLE_VERSION}.tar.gz /
#RUN tar xzf ${GUACAMOLE_VERSION}.tar.gz
#RUN rm ${GUACAMOLE_VERSION}.tar.gz
RUN cd guacamole-server-${GUACAMOLE_VERSION} && \
    ./configure --help && \
    ./configure
RUN apt-get install -y make checkinstall
RUN cd guacamole-server-${GUACAMOLE_VERSION} && make
RUN cd guacamole-server-${GUACAMOLE_VERSION} && checkinstall -y --type=debian --install=no --pkgname=guacamole-server --pkgversion=${GUACAMOLE_VERSION} make install

#ENV GUACAMOLE_WAR_SHA1 07d194593db296d20d87b858b02e7816fb4a9315
#RUN echo $GUACAMOLE_WAR_SHA1  guacamole.war > guacamole.war.sha1
#RUN curl -L -o guacamole.war http://sourceforge.net/projects/guacamole/files/current/binary/guacamole-${GUACAMOLE_VERSION}.war/download 
#RUN sha1sum -c guacamole.war.sha1
#CMD 
