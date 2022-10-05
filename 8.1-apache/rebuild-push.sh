#!/bin/bash

docker image rm -f "jalamanderman/silverstripe-base:8.1-apache"
docker build --no-cache -t jalamanderman/silverstripe-base:8.1-apache .
docker push "jalamanderman/silverstripe-base:8.1-apache"
