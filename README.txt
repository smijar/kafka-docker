BUILD kafka docker image:

Normal:
$ docker build -t sm/kafka .

with no cache (removes old remnants and builds a fresh image):
$ docker build -t sm/kafka --no-cache .

DEBUG image while building:
$ docker run --rm sm/kafka /bin/bash

RUN docker image (leave no intermediate containers):
$ docker run -e PROGNAME='kafka' --rm --name kafka sm/kafka

EXAMINE while running:
$ docker exec -t kafka  /bin/bash

STOP the container:
$ docker stop kafka

#================================================================
# Running with compose
#================================================================
$ ./up.sh


#================================================================
# Running without compose
#================================================================

CREATE the network:
$ docker network create mynet

To list:
docker network ls

To remove:
docker network rm mynet

RUN ZOOKEEPER:
USE --env-file ./my_env if u need to add more environment variables
$ docker run -e PROGNAME='zookeeper' --rm --name zookeeper sm/kafka

RUN KAFKA:
$ docker run -e PROGNAME='kafka' --rm --name kafka sm/kafka


CLEAN up docker networks:
The easiest way to do that is to

remove all the user-created networks using docker network rm
stop the docker daemon
cleanup iptables : iptables -F && iptables -F -t nat
RESTART the docker daemon
create user-defined network
try out your use-case.
