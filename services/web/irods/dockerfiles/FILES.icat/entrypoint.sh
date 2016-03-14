#!/bin/bash

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

	#change irods user's irodsEnv file to point to localhost, since it was configured with a transient Docker container's $
	#sed -i 's/^irodsHost.*/irodsHost localhost/' /var/lib/irods/.irods/.irodsEnv
	sed -i 's/"irodsHost:".*/"irods_hods": "localhost"/' /var/lib/irods/.irods/irods_environment.json

	# this script must end with a persistent foreground process
	sleep infinity

else
    exec "$@"
fi

