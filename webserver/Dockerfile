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
RUN mkdir -p /guacamole/lib

WORKDIR /guacamole
ENV GUACAMOLE_HOME /guacamole
COPY guacamole.properties /guacamole/
#COPY user-mapping.xml /guacamole/


#ENV GUACAMOLE_MARIADB_CONNECTOR_MD5 1d779d93425b82f01757bf6f7b82379f


# Fetch and install MariaDB connector
#RUN echo $GUACAMOLE_MARIADB_CONNECTOR_MD5  mariadb.jar > /guacamole/lib/mariadb.jar.md5
#RUN curl -L -o /guacamole/lib/mariadb.jar https://downloads.mariadb.org/interstitial/client-java-1.1.7/mariadb-java-client-1.1.7.jar/from/http%3A//ftp.ddg.lth.se/mariadb
#RUN cd /guacamole/lib && md5sum -c --quiet mariadb.jar.md5



ENV GUACAMOLE_AUTH_MYSQL_SHA1 a68166aec88784325f3358a16dedc70f2df73342
RUN mkdir -p /guacamole/lib

# Fetch and install Guacamole MySQL auth extension libs
RUN echo $GUACAMOLE_AUTH_MYSQL_SHA1  guacamole-auth-mysql.tar.gz > guacamole-auth-mysql.tar.gz.sha1 && \
    curl -L -o guacamole-auth-mysql.tar.gz http://sourceforge.net/projects/guacamole/files/current/extensions/guacamole-auth-mysql-0.9.4.tar.gz/download && \
    sha1sum -c --quiet guacamole-auth-mysql.tar.gz.sha1 && \
    tar xzf guacamole-auth-mysql.tar.gz && \
    mv guacamole-auth-mysql-${GUACAMOLE_VERSION}/lib/*.jar /guacamole/lib && \
    rm -rf guacamole-auth-mysql*


ENV MYSQL_CONNECTOR_MD5 ad4c875c719247f8e8c41cd7f0609e00

# Fetch and install MySQL connector
RUN echo $MYSQL_CONNECTOR_MD5  mysql-connector.tar.gz > mysql-connector.tar.gz.md5
RUN curl -L -o mysql-connector.tar.gz http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.tar.gz
RUN md5sum -c --quiet mysql-connector.tar.gz.md5
RUN tar xzf mysql-connector.tar.gz
RUN mv mysql-connector-java-*/mysql-connector-java-*.jar /guacamole/lib
RUN rm -rf mysql-connector*