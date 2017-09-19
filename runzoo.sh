# first remove previous container of same type and remove it
docker stop myzooctr
docker rm myzooctr

# tries to create a new network "mynet" and ignores return code if already present
docker network create mynet || :

# run new one in daemon mode and attach to its output
# run in daemon mode
docker run \
-v `pwd`/config/server.properties:/opt/kafka/config/server.properties \
--rm \
--net mynet \
-e PROGNAME='zookeeper' \
-p 2181:2181/tcp \
-d \
--name myzooctr sm/kafka

docker attach myzooctr