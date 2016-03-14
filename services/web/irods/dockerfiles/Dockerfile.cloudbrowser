FROM ubuntu:14.04
MAINTAINER willis8@illinois.edu

RUN apt-get update ; apt-get upgrade -y

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jdk tomcat7 curl

RUN curl -s https://code.renci.org/gf/download/frsrelease/239/2717/irods-cloud-backend.war -o /var/lib/tomcat7/webapps/irods-cloud-backend.war

COPY FILES.cloudbrowser/server.xml /etc/tomcat7/

ENV CATALINA_BASE=/var/lib/tomcat7
ENV CATALINA_HOME=/usr/share/tomcat7
ENV JRE_HOME=/usr/lib/jvm/java-7-openjdk-amd64

COPY FILES.cloudbrowser/entrypoint.sh /

EXPOSE 8080
CMD [ "/entrypoint.sh", "cloudbrowser" ]
