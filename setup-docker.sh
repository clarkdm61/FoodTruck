#!/bin/bash

# build the flask container
docker build -t clarkdm61/foodtrucks-web .

# create the network
docker network create foodtrucks

# fix VM memory for elasticsearch container
sudo sysctl -w vm.max_map_count=262144

# start the ES container
docker run -d --net foodtrucks -p 9200:9200 -p 9300:9300 --name es elasticsearch

# start the flask app container
docker run -d --net foodtrucks -p 5000:5000 --name foodtrucks-web clarkdm61/foodtrucks-web
