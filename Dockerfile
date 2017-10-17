FROM ubuntu:14.04

# VERSION 1.5
# This is just a dockerized version of [this work](https://github.com/Smile-SA/smile-magento-elasticsearch)

LABEL maintainer="voldedore@gmail.com"

# Build arguments
ARG CLUSTER_NAME
ENV CLUSTER_NAME mkg_es

ENV HOST localhost

# Install wget, curl, and add-apt-repository tool
RUN apt-get update; \
  apt-get install -y wget software-properties-common curl

# Add repo (Java and ES 1.5)
RUN add-apt-repository ppa:openjdk-r/ppa; \
  wget -O - http://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -; \
  echo "deb http://packages.elastic.co/elasticsearch/1.5/debian stable main" > /etc/apt/sources.list.d/elasticsearch.list;

# Install Java and ElasticSearch
RUN apt-get update; \
  apt-get install -y openjdk-8-jdk elasticsearch;

# Install plugins for ES module for Magento to work
RUN /usr/share/elasticsearch/bin/plugin -i mobz/elasticsearch-head; \
  /usr/share/elasticsearch/bin/plugin -i lmenezes/elasticsearch-kopf/v1.6.1; \
  /usr/share/elasticsearch/bin/plugin -i elasticsearch/elasticsearch-analysis-icu/2.5.0; \
  /usr/share/elasticsearch/bin/plugin -i elasticsearch/elasticsearch-analysis-phonetic/2.5.0; \
  /usr/share/elasticsearch/bin/plugin -i elasticsearch/elasticsearch-analysis-smartcn/2.5.0;

# Auto run when system is on
RUN update-rc.d elasticsearch defaults

# Overwrite settings
COPY scripts/install /var/es/install

RUN sed -e "s/CLUSTER_NAME/\"$CLUSTER_NAME\"/;s/HOSTS/$HOSTS/;" /var/es/install/es-conf-templates/elasticsearch.yml > /etc/elasticsearch/elasticsearch.yml; \
  cp -rfv /var/es/install/es-conf-templates/logging.yml /etc/elasticsearch/;

ENTRYPOINT service elasticsearch start && /bin/bash

EXPOSE 9200
