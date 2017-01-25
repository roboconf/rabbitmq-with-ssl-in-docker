#!/bin/bash

set -eu

cd /home/testca
openssl req -x509 -config openssl.cnf -newkey rsa:2048 -days 365 -out cacert.pem -outform PEM -subj /CN=MyTestCA/ -nodes
openssl x509 -in cacert.pem -out cacert.cer -outform DER

# On server side
cd /home/server
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=$(hostname)/O=server/ -nodes
cd /home/testca
openssl ca -config openssl.cnf -in /home/server/req.pem -out /home/server/cert.pem -notext -batch -extensions server_ca_extensions
cd /home/server
openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem -passout pass:roboconf

# On client side
cd /home/client
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=$(hostname)/O=client/ -nodes
cd /home/testca
openssl ca -config openssl.cnf -in /home/client/req.pem -out /home/client/cert.pem -notext -batch -extensions client_ca_extensions
cd /home/client
openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem -passout pass:roboconf

# Restart rabbitmq server
#service rabbitmq-server restart
