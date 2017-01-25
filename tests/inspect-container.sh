#!/bin/bash 

findRabbitmqPid() {
	echo $(ps -aux | grep rabbitmq | grep -v grep | grep -v "/usr/lib/erlang" | grep -v "erl_child" | grep -v "inet_gethost")
}

findSSL() {
	echo $(grep "SSL" /var/log/rabbitmq/startup_log)
}

# Check
if [ -n "$(findRabbitmqPid)" ] && [ -n "$(findSSL)" ]; then
	RETVAL=1
	rm -rf "/tmp/rabbitmq-ssl/result.txt"
fi
