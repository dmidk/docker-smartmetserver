#!/bin/bash

source env.sh

#Stop any previous containers with this name before running
if [ ! "$(docker ps -q -f name=$CONTAINERNAME)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$CONTAINERNAME)" ]; then
        echo "Removing container $CONTAINERNAME"
        docker rm $CONTAINERNAME
    fi
else
    docker stop $CONTAINERNAME
    docker rm $CONTAINERNAME
fi

docker run -d --restart=always --name $CONTAINERNAME -p 8080:8080 -v $HOME/data:/smartmet/data $IMAGENAME