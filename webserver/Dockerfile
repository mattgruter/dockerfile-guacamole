FROM tomcat:7-jre7
MAINTAINER Matthias Grüter <matthias@grueter.name>

# To update, check http://guac-dev.org/releases
ENV GUACAMOLE_VERSION 0.9.4
ENV GUACAMOLE_WAR_SHA1 07d194593db296d20d87b858b02e7816fb4a9315


### Webserver
# Disable Tomcat's manager application.
RUN rm -rf webapps/*

# Fetch and install Guacamole war archive.
RUN echo $GUACAMOLE_WAR_SHA1  ROOT.war > webapps/ROOT.war.sha1 && \
    curl -L -o webapps/ROOT.war http://sourceforge.net/projects/guacamole/files/current/binary/guacamole-${GUACAMOLE_VERSION}.war/download && \
    cd webapps && sha1sum -c --quiet ROOT.war.sha1

# Expose tomcat runtime options through the RUNTIME_OPTS environment variable.
#   Example to set the JVM's max heap size to 256MB use the flag
#   '-e RUNTIME_OPTS="-Xmx256m"' when starting a container.
RUN echo 'export CATALINA_OPTS="$RUNTIME_OPTS"' > bin/setenv.sh


### Configuration
RUN mkdir -p /guacamole
VOLUME /guacamole
WORKDIR /guacamole
ENV GUACAMOLE_HOME /guacamole
COPY guacamole.properties /guacamole/
COPY user-mapping.xml /guacamole/
