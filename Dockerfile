FROM ubuntu:14.04

# TAG 1.5

RUN apt-get update; \
  apt-get install -y wget curl software-properties-common; \
  add-apt-repository ppa:openjdk-r/ppa; \
  apt-get update; \
  apt-get install -y openjdk-8-jdk; \
  update-alternatives --config java; \
  update-alternatives --config javac;

COPY install /var/es/install

CMD tail -f /dev/null

EXPOSE 9200
