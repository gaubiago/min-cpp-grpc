#!/bin/bash

# Check if the container exists
if docker ps -a --format '{{.Names}}' | grep -q "min-cpp-grpc"; then
    echo "Container min-cpp-grpc already exists. Starting it..."
    docker start min-cpp-grpc
else
    echo "Container min-cpp-grpc does not exist. Creating and starting it..."
    docker run -dit -v $(pwd)/home:/home --name min-cpp-grpc min-cpp-grpc:1.0
fi