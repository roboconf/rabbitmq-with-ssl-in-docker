#!/bin/bash

IMAGE_NAME="test-rabbitmq-ssl"

docker build --no-cache=true -t ${IMAGE_NAME} ..
