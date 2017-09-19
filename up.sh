#!/bin/bash

# script to start docker-compose and add networking to the host machine
# for services running there (alias network on OS X)
# cd ..
if [ "$(uname)" == "Darwin" ]; then
    sudo ifconfig lo0 alias 172.20.123.1
fi
docker-compose -f docker-compose.yml up --remove-orphans

while getopts ":d" opt; do
  case $opt in
    d)
      #echo "-a was triggered!" >&2
      # running as a daemon
      echo "running as a daemon"
      docker-compose -d -f docker-compose.yml up --remove-orphans
      ;;
    \?)
      # running in the foreground
      # echo "Invalid option: -$OPTARG" >&2
      echo "running in the foreground"
      docker-compose -f docker-compose.yml up --remove-orphans
      ;;
  esac
done
