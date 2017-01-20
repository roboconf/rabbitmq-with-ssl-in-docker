FROM rabbitmq:3.6.6

RUN apt-get update 
RUN apt-get install openssl -y \ 
&& mkdir -p /home/testca/certs \
&& mkdir -p /home/testca/private \
&& chmod 700 /home/testca/private \
&& echo 01 > /home/testca/serial \
&& touch /home/testca/index.txt

ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config
ADD openssl.cnf /home/testca


RUN mkdir -p /home/server \
&& mkdir -p /home/client

ADD ssl.sh /home

RUN chmod +x /home/ssl.sh
CMD ["/home/ssl.sh" > toto.txt]
RUN /etc/init.d/rabbitmq-server restart


