#!/bin/env bash
container="main"
image="aaraz/primage:main"
if docker stop "$container";then
    echo "Stopped container $container successfully"
    if docker container rm "$container";then
        echo "Removed container $container successfully"
        # docker run command below
        if docker run -d --name "$container" -p 80:80 "$image";then
            echo "Created container $container successfully"
        else
            echo "Failed to create container $container"
            exit 1
        fi
    else
        echo "Failed to remove container $container"
        exit 1
    fi
else
    echo "$container does'nt exist"
    exit 1
fi

