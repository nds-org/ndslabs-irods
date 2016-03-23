#!/bin/bash

set -e

if [ "$1" = 'icat' ]; then
	# generate configuration responses
	/opt/irods/genresp.sh /opt/irods/setup_responses

	if [ -n "$RODS_PASSWORD" ]; then 
    	sed -i "14s/.*/$RODS_PASSWORD/" /opt/irods/setup_responses
	fi

	if [ -n "$RODS_ZONE" ]; then
    	sed -i "3s/.*/$RODS_ZONE/" /opt/irods/setup_responses
	fi

	# set up the iCAT database
	service postgresql start
	/opt/irods/setupdb.sh /opt/irods/setup_responses

	# set up iRODS
	/opt/irods/config.sh /opt/irods/setup_responses

	#sed -i 's/^irodsHost.*/irodsHost localhost/' /var/lib/irods/.irods/.irodsEnv
	sed -i 's/"irodsHost:".*/"irods_hods": "localhost"/' /var/lib/irods/.irods/irods_environment.json

	sed -i "s/HOSTNAME/$HOSTNAME/" /etc/supervisor/conf.d/supervisord.conf
	sed -i "s/RODS_ZONE/$RODS_ZONE/" /etc/supervisor/conf.d/supervisord.conf

	RODS_PASSWORD=`sed '14q;d' /opt/irods/setup_responses`

	# Initialize the rods user environemtn
	mkdir -p ~/.irods
cat << EOF > ~/.irods/irods_environment.json
{
   	"irods_host": "localhost",
   	"irods_port": 1247,
   	"irods_user_name": "rods",
   	"irods_zone_name": "$RODS_ZONE"
}
EOF
	iinit $RODS_PASSWORD

	# this script must end with a persistent foreground process
	/usr/bin/supervisord

else
    exec "$@"
fi

