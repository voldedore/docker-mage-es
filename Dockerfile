FROM ubuntu:14.04

RUN apt-get update;

COPY install/bin /etc/elasticsearch/bin
COPY install/config /etc/elasticsearch/config
COPY install/lib /etc/elasticsearch/lib

WORKDIR /etc/elasticsearch/

CMD tail -f /dev/null

EXPOSE 9200
