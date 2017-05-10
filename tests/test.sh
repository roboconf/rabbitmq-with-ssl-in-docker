#!/bin/bash

# Launch a Docker container from rabbitmq-ssl image 
IMAGE_NAME=rabbitmq-with-ssl
SUCCESS=true
TMP_DIR=/tmp/rabbitmq-ssl/
mkdir -p $TMP_DIR
TMP_FILE="$TMP_DIR/result.txt"
touch $TMP_FILE

LOC=`dirname "$(readlink -f "$0")"`

docker run -d \
	-v $TMP_DIR:$TMP_DIR \
	-v $LOC:/tmp/rabbitmq-ssl-scripts \
	--name "rbtq-ssl" $IMAGE_NAME

sleep 3

INSPECT_OUTPUT=$(docker inspect -f {{.State.Running}} "rbtq-ssl")
if [[ "${INSPECT_OUTPUT}"  == "false" ]]; then
	echo "Container 'rbtq-ssl' is not running."
	SUCCESS="false"
else
	echo "Container 'rbtq-ssl' is running."
fi

# Some verifications

docker exec rbtq-ssl /bin/bash /tmp/rabbitmq-ssl-scripts/inspect-container.sh
sleep 3

if [ -f "$TMP_FILE" ]; then
	echo "Failed to find a rabbitmq process (PID) in the 'rbtq-ssl' container."
	SUCCESS="false"
else
	echo "A rabbitmq process (PID) was successfully found in the 'rbtq-ssl' container."
fi



echo
echo "Deleting the created container..."
echo

docker kill "rbtq-ssl" >/dev/null 2>&1
if [[ $? != "0" ]]; then
	echo "Failed to kill and delete the 'rbtq-ssl' container."
	SUCCESS="false"
fi

docker rm -f "rbtq-ssl" >/dev/null 2>&1
if [[ $? != "0" ]]; then
	echo "Failed to kill and delete the 'rbtq-ssl' container."
	SUCCESS="false"
fi



echo
echo "Conclusion..."
echo

if [[ "${SUCCESS}" == "true" ]]; then
	echo "Tests were successful."
else
	echo "Tests failed."
fi
