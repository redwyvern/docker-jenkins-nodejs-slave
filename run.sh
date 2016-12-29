#!/bin/bash -e

# An example script to run Postfix in production. It uses data volumes under the $DATA_ROOT directory.
# By default /srv.

NAME='nodejs-slave'

HOST_NAME=nodejs-slave
NETWORK_NAME=dev_nw
NETWORK_ALIAS=nodejs-slave

docker stop "${NAME}" 2>/dev/null && sleep 1
docker rm "${NAME}" 2>/dev/null && sleep 1
docker run --detach=true --name "${NAME}" --hostname "${HOST_NAME}" \
    --network=${NETWORK_NAME} \
    --network-alias ${NETWORK_ALIAS} \
    redwyvern/jenkins-nodejs-slave
