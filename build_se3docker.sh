#!/bin/bash

# 23-09-2018
# Nicolas Roudninski
#

cd /home/nicolas/projets/docker/se3mysql/
docker-compose down
sleep 5
docker-compose up -d
sleep 10
cd /home/nicolas/projets/docker/docker_se3/
docker build --network se3network -t se3:latest .
