#!/bin/bash

IMAGE_NAME="rabbitmq-with-ssl"

docker build --no-cache=true -t ${IMAGE_NAME} ..
