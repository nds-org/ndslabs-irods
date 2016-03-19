docker build -t ndslabs/irods-icat:4.1.3 -f icat/Dockerfile icat
docker build -t ndslabs/cloudbrowser:latest -f cloudbrowser/Dockerfile cloudbrowser
docker build -t ndslabs/cloudbrowser-ui:latest -f cloudbrowser-ui/Dockerfile cloudbrowser-ui
