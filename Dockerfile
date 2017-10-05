FROM ubuntu:14.04

RUN apt-get update; \
  apt-get install -y wget;

COPY scripts/install /var/es/install

RUN chmod u+x /var/es/install/install-es.sh; sync; \
  bash /var/es/install/install-es.sh mkg_es localhost:9200

EXPOSE 9200
