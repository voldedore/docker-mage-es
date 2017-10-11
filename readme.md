# Dockerized Elastic Search for Magento modules

This is just a dockerized version of [this work](https://github.com/Smile-SA/smile-magento-elasticsearch)

### Usage

1. Pull the image

       docker pull voldedore/mkg_es:1.5

2. Run the container

       docker run -it -p "9200:9200" voldedore/mkg_es:1.5

### Options

- Persistent data

  Data of Elastic Search are stored in /var/lib/elasticsearch. So we need to put `-v` flag in the docker run command.

       docker run -it -p "9200:9200" -v /host/machine/:/var/lib/elasticsearch voldedore/mkg_es:1.5

- Detach mode

  Just add `-d` to docker run command
