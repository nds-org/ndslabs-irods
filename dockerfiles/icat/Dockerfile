FROM ubuntu:14.04
# Based on original image from 
# https://github.com/irods/contrib/blob/master/irods-docker/icat/Dockerfile
# MAINTAINER danb@renci.org
MAINTAINER willis8@illinois.edu

RUN apt-get update ; apt-get upgrade -y

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql wget libcurl4-gnutls-dev psmisc supervisor

#install iRODS
RUN wget ftp://ftp.renci.org/pub/irods/releases/4.1.3/ubuntu14/irods-database-plugin-postgres-1.5-ubuntu14-x86_64.deb -O /tmp/irods-dbplugin.deb
RUN wget ftp://ftp.renci.org/pub/irods/releases/4.1.3/ubuntu14/irods-icat-4.1.3-ubuntu14-x86_64.deb -O /tmp/irods-icat.deb

# install package dependencies to prevent Docker build from erring out
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y `dpkg -I /tmp/irods-icat.deb | sed -n 's/^ Depends: //p' | sed 's/,//g'`
RUN dpkg -i /tmp/irods-icat.deb

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y `dpkg -I /tmp/irods-dbplugin.deb | sed -n 's/^ Depends: //p' | sed 's/,//g'`
RUN dpkg -i /tmp/irods-dbplugin.deb


RUN mkdir /opt/ndslabs && wget https://github.com/nds-org/ndslabs-irods-federate/releases/download/v0.1poc3/ndslabs-irods-federate-linux-amd64 -O /opt/ndslabs/ndslabs-irods-federate && chmod +x /opt/ndslabs/ndslabs-irods-federate

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir /opt/irods

COPY *.sh /opt/irods/
RUN chmod a+x /opt/irods/*.sh

VOLUME /var/lib/irods/iRODS/Vault
VOLUME /var/lib/postgresql/9.3/main

COPY irods_setup.pl /var/lib/irods/iRODS/scripts/perl/irods_setup.pl
COPY entrypoint.sh /
COPY Dockerfile /

EXPOSE 1247
EXPOSE 8080
#EXPOSE 1248
CMD ["/entrypoint.sh", "icat"]
