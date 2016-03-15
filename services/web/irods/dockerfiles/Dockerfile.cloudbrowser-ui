FROM ubuntu:14.04
MAINTAINER willis8@illinois.edu

RUN apt-get update ; apt-get upgrade -y

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 wget zip

RUN a2enmod proxy proxy_ajp

RUN cd /tmp \
  && wget https://code.renci.org/gf/download/frsrelease/239/2712/irods-cloud-frontend.zip  \
  && unzip irods-cloud-frontend.zip \
  && mv irods-cloud-frontend/* /var/www/html

COPY FILES.cloudbrowser-ui/globals.js /var/www/html/app/components
COPY FILES.cloudbrowser-ui/default.conf /etc/apache2/sites-available/000-default.conf
COPY FILES.cloudbrowser-ui/entrypoint.sh /

EXPOSE 80
CMD ["/entrypoint.sh", "cloudbrowser"]
