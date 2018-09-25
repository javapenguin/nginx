#!/bin/bash

source version.sh

docker build --pull --no-cache --rm \
-t javapenguin/nginx:${VERSION} \
-t javapenguin/nginx:latest \
.
