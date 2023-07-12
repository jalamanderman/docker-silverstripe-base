#!/bin/bash

docker image rm -f "dnadev/docker-silverstripe-base:8.1-apache"
docker build --no-cache -t dnadev/docker-silverstripe-base:8.1-apache .
docker push "dnadev/docker-silverstripe-base:8.1-apache"
