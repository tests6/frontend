#!/bin/bash

# Stop the Docker container
docker stop ayomi-webserver

# Remove the Docker container
docker rm ayomi-webserver

# Remove the Docker image
docker rmi ayomi-webserver