#!/bin/bash

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        echo "** Trapped CTRL-C"
        exit 1
}


cd /opt/kafka/

#if [ -n $PROGNAME -eq "kafka" ]

if [ $PROGNAME == "kafka" ]
then
    bin/kafka-server-start.sh config/server.properties
elif [ $PROGNAME == "zookeeper" ]
then
    bin/zookeeper-server-start.sh config/zookeeper.properties
else
    echo "PROGNAME environment variable needs be either kakfa or zookeeper"
fi
