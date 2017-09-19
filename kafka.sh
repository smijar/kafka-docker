# first remove previous container of same type and remove it
docker stop kafka

# run new one in daemon mode and attach to its output
# run in daemon mode
docker run --rm -p 2181:2181/tcp -d --name kafka kafkaimg
docker attach kafka
