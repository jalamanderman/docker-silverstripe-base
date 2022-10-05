#!/bin/bash

docker image rm -f "jalamanderman/silverstripe-base:7.4-apache"
docker build --no-cache -t jalamanderman/silverstripe-base:7.4-apache .
docker push "jalamanderman/silverstripe-base:7.4-apache"
