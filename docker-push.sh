#!/usr/bin/env bash

source version.sh

docker push javapenguin/nginx:${VERSION}
docker push javapenguin/nginx:latest
