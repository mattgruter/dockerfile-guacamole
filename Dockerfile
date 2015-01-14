FROM tomcat:7-jre7

MAINTAINER Matthias Grüter <matthias@grueter.name>

# To update, check http://guac-dev.org/releases
ENV GUACAMOLE_VERSION 0.9.4
ENV GUACAMOLE_WAR_SHA1 07d194593db296d20d87b858b02e7816fb4a9315
ENV GUACAMOLE_SERVER_DEB_SHA1 d115809200d5ec074c8c03dc5040fbfe54d6a08b


### webserver / guacamole-client
# Disable Tomcat's manager application.
RUN rm -rf webapps/*

# Fetch and install Guacamole war archive.
RUN echo $GUACAMOLE_WAR_SHA1  guacamole.war > webapps/guacamole.war.sha1
RUN curl -L -o webapps/guacamole.war http://sourceforge.net/projects/guacamole/files/current/binary/guacamole-${GUACAMOLE_VERSION}.war/download 
RUN cd webapps && sha1sum -c guacamole.war.sha1

# Expose tomcat runtime options through the RUNTIME_OPTS environment variable.
#   Example to set the JVM's max heap size to 256MB use the flag
#   '-e RUNTIME_OPTS="-Xmx256m"' when starting a container.
RUN echo 'export CATALINA_OPTS="$RUNTIME_OPTS"' > bin/setenv.sh
###


### guacd / guacamole-server
COPY guacamole-server_${GUACAMOLE_VERSION}-1_amd64.deb /guacd/guacamole-server.deb
WORKDIR /guacd
RUN echo $GUACAMOLE_SERVER_DEB_SHA1  guacamole-server.deb > guacamole-server.deb.sha1
RUN sha1sum -c guacamole-server.deb.sha1
RUN dpkg -i guacamole-server.deb
###


### configuration
COPY guacamole.properties /guacamole/
COPY user-mapping.xml /guacamole/


# Guacamole home
RUN mkdir -p /guacamole/.guacamole
RUN ln -s /guacamole/guacamole.properties /guacamole/.guacamole/
ENV GUACAMOLE_HOME /guacamole

# Expose Guacamole home directory
VOLUME /guacamole
WORKDIR /guacamole

# deps
RUN apt-get update
RUN apt-get install -y libcairo2 libpng12-0 libossp-uuid16 libvncserver0

