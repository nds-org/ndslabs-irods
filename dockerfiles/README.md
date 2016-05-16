## iRODS 4.1.3

This is a preliminary implementation of the [iRods](https://docs.irods.org/4.1.3/manual/installation/) iCAT and Cloudbrowser services for NDS Labs. The Docker images are based on the official images [RENCI](https://github.com/irods/contrib/tree/master/irods-docker), with changes required to run in NDS Labs.

### NDS Labs Docker images

The images should be available from the [NDS Labs Dockerhub account](https://hub.docker.com/u/ndslabs/)

### Changes

* iCAT: Installs 4.1.3 with the NDS Labs entrypoint.sh script
* Cloudbrowser: Installs the 1.0 Cloudbrowser REST API server 
* Cloudbrowser-UI: Installs the 1.0 Cloudbrowser Angular UI


### Starting iRODS services under docker

```
docker run --name icat  --env=RODS_PASSWORD=test --env RODS_ZONE=myzone -p 1247:1247 -d ndslabs/irods-icat:4.1.3
```

```
docker run --env IRODS_ZONE=myzone --name cloudbrowser -p 8009:8009 --link icat:icat -d ndslabs/cloudbrowser:latest
```

```
docker run --link cloudbrowser:cloudbrowser -p 80:80  -d ndslabs/cloudbrowser-ui:latest
```

### Simple test case
* Open <host>:80 in your browser (Cloudbrowser UI)
* Login using the "rods" user with the specified password
* You should see the CloudBrowser interface with the default "myzone" zone displayed
