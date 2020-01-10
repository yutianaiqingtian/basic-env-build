#!/bin/bash

DOCKER_HOST_IP=$(ifconfig en0 | grep inet\[\ \] | awk \{print\ \$2\})

echo "DOCKER_HOST_IP=${DOCKER_HOST_IP}" > .env
