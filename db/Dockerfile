FROM dockerfile/mariadb 
MAINTAINER Matthias Grüter <matthias@grueter.name>

# To update, check http://guac-dev.org/releases
ENV GUACAMOLE_VERSION 0.9.4
ENV GUACAMOLE_AUTH_MYSQL_SHA1 a68166aec88784325f3358a16dedc70f2df73342

COPY create-user.sql /schema/000-create-user.sql

# Fetch and install Guacamole MySQL auth extension.
RUN echo $GUACAMOLE_AUTH_MYSQL_SHA1  guacamole-auth-mysql.tar.gz > guacamole-auth-mysql.tar.gz.sha1 && \
    curl -L -o guacamole-auth-mysql.tar.gz http://sourceforge.net/projects/guacamole/files/current/extensions/guacamole-auth-mysql-0.9.4.tar.gz/download && \
    sha1sum -c --quiet guacamole-auth-mysql.tar.gz.sha1 && \
    tar xzf guacamole-auth-mysql.tar.gz && \
    mv guacamole-auth-mysql-${GUACAMOLE_VERSION}/schema/*.sql /schema && \
    rm -rf guacamole-auth-mysql*  

# Setup database when container is started
RUN \
  echo "set -m" > /run.sh && \
  echo "mysqld_safe &" >> /run.sh && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /run.sh && \
  echo "mysqladmin create guacamole" >> /run.sh && \
  echo "cat /schema/*.sql | mysql guacamole" >> /run.sh && \
  echo "fg" >> /run.sh

CMD ["bash", "/run.sh"]
