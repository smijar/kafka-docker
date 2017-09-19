##########################################
# SM - KAFKA DOCKER FILE
##########################################
FROM java:openjdk-8-jre
MAINTAINER sm

# Drop entrypoint script in place
ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.11.0.1
ENV KAFKA_HOME /opt/kafka_"$KAFKA_VERSION"

# Install blah blah stuff
# wget supervisor dnsutils
RUN apt-get update && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# add s6 (https://blog.tutum.co/2015/05/20/s6-made-easy-with-the-s6-overlay/) process supervisor container
# why not supervisord - https://blog.tutum.co/2014/12/02/docker-and-s6-my-new-favorite-process-supervisor/
RUN wget -q https://github.com/just-containers/s6-overlay/releases/download/v1.9.1.3/s6-overlay-amd64.tar.gz
RUN tar xzf ./s6-overlay-amd64.tar.gz -C /

# kafka download
ENV DOWNLOAD_URL http://apache.mirrors.spacedump.net/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
RUN echo "$DOWNLOAD_URL"
RUN wget -q "$DOWNLOAD_URL" -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
RUN ls -l /tmp/
RUN tar xzf /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt/
RUN mv /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION" /opt/kafka

# on start run radiusd in debug mode

# add s6 (https://blog.tutum.co/2015/05/20/s6-made-easy-with-the-s6-overlay/) process supervisor container
# why not supervisord - https://blog.tutum.co/2014/12/02/docker-and-s6-my-new-favorite-process-supervisor/
RUN wget https://github.com/just-containers/s6-overlay/releases/download/v1.9.1.3/s6-overlay-amd64.tar.gz
RUN tar xzf ./s6-overlay-amd64.tar.gz -C /

ENTRYPOINT ["/opt/kafka/entrypoint.sh"]
ENTRYPOINT ["/init"]
CMD ["/opt/entrypoint.sh"]
