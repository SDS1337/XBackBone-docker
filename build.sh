#!/bin/sh

# travis trigger

docker kill xbackbone
docker rm xbackbone

docker build -t sds1337/xbackbone-docker ./src/

mkdir -p /srv/xbb/storage
mkdir -p /srv/xbb/database
mkdir -p /srv/xbb/logs

chown -R 1000:1000 /srv/xbb

docker run -p 80:80 \
		-v /srv/xbb/storage:/app/storage \
		-v /srv/xbb/database:/app/resources/database \
		-v /srv/xbb/logs:/app/logs \
		-e URL=http:\/\/127.0.0.1 \
		--name xbackbone \
		sds1337/xbackbone-docker
