#!/bin/env bash

container="$1"
image="$2"

if [ ! "$container" ] || [ ! "$image" ] ;then
  echo "$0 [container] [image]"
  exit 0
fi

if docker stop "$container" >>  /dev/null;then
  echo "Stopped container $container successfully"
  if docker container rm "$container" >> /dev/null;then
    echo "Removed container $container successfully"
    if docker run -d --name "$container" -p 8000:8000 "$image" >> /dev/null;then
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
  echo "Failed to stop container $container"
  exit 1
fi

