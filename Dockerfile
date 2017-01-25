FROM rabbitmq:3.6.6

RUN apt-get update 
RUN apt-get install openssl -y  \ 
&& mkdir -p /home/testca/certs \
&& mkdir -p /home/testca/private \
&& chmod 700 /home/testca/private \
&& echo 01 > /home/testca/serial \
&& touch /home/testca/index.txt

COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config
COPY openssl.cnf /home/testca


RUN mkdir -p /home/server \
&& mkdir -p /home/client

VOLUME /home/client

COPY ssl.sh /home

RUN chmod +x /home/ssl.sh
RUN /bin/bash /home/ssl.sh

RUN /etc/init.d/rabbitmq-server restart

