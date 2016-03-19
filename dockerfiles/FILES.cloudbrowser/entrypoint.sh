#!/bin/bash

#!/bin/bash

set -e


if [ "$1" = 'cloudbrowser' ]; then

	if [ -n "$ICAT_PORT_1247_TCP_ADDR" ]; then 
		echo "beconf.login.preset.host='"$ICAT_PORT_1247_TCP_ADDR"'" >> /etc/irods-cloud-backend-config.groovy
		echo "beconf.login.preset.port="$ICAT_PORT_1247_TCP_PORT"" >> /etc/irods-cloud-backend-config.groovy
	fi

	if [ -n "$IRODS_ZONE" ]; then
		echo "beconf.login.preset.zone='"$IRODS_ZONE"'" >> /etc/irods-cloud-backend-config.groovy
	else
		echo "beconf.login.preset.zone='tempZone'" >> /etc/irods-cloud-backend-config.groovy
	fi

	echo "beconf.login.preset.auth.type='STANDARD'" >> /etc/irods-cloud-backend-config.groovy
	echo "beconf.login.preset.enabled=true" >> /etc/irods-cloud-backend-config.groovy

	/usr/share/tomcat7/bin/catalina.sh run

else
    exec "$@"
fi

