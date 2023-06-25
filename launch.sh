#!/bin/bash

# Build the Docker image
docker build --build-arg BACKEND_IP=$(hostname -I | awk '{print $1; exit}') -t ayomi-webserver .

# Run the Docker container
docker run -d -p 8080:80 --name ayomi-webserver ayomi-webserver

# Connect to the network
docker network connect ayomi-network ayomi-webserver