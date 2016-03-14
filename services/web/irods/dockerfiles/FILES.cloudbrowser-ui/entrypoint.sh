#!/bin/bash

set -e

if [ "$1" = 'cloudbrowser' ]; then

	if [ "$CLOUDBROWSER_ADDR" == "" ]; then
   		if [ -n "$CLOUDBROWSER_PORT_8080_TCP_PORT" ]; then
   	     	CLOUDBROWSER_ADDR="${CLOUDBROWSER_PORT_8080_TCP_ADDR}:${CLOUDBROWSER_PORT_8080_TCP_PORT}"
    	fi
	fi

  sed -i 's/CLOUDBROWSER_BACKEND/'"${CLOUDBROWSER_ADDR}"'/' /etc/apache2/sites-available/000-default.conf

  echo "Starting Apache2"
  service apache2 start
  sleep infinity
  
else
    exec "$@"
fi


