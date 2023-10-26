#!/bin/env bash

container="mysite"
image="aaraz/primage:mysite_github"

if [ ! "$container" ] || [ ! "$image" ] ;then
    echo "missing container name anf image in file"
    exit 0
fi

if docker stop "$container" >>  /dev/null;then
    echo "Stopped container $container successfully"
    if docker container rm "$container" >> /dev/null;then
        echo "Removed container $container successfully"
        if docker pull "$image" >>  /dev/null;then
            echo "Pulled image $image successfully"
            if docker run -d --name "$container" -p 80:80 "$image" >> /dev/null;then
                echo "Created container $container successfully"
            else
                echo "Failed to create container $container"
                exit 1
            fi
        else
            echo "Failed to pull image $image"
            exit 1
        fi
    else
        echo "Failed to remove container $container"
        exit 1
    fi
else
    # echo "Failed to stop container $container"
    # exit 1
    docker pull "$image"
    docker run -d --name "$container" -p 80:80 "$image"
    exit 0
fi
