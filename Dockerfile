FROM rabbitmq:3.6.6

RUN apt-get update \
	&& apt-get install openssl -y  \ 
	&& mkdir -p /home/testca/certs \
	&& mkdir -p /home/testca/private \
	&& chmod 700 /home/testca/private \
	&& echo 01 > /home/testca/serial \
	&& touch /home/testca/index.txt

COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config
COPY openssl.cnf /home/testca
COPY prepare-server.sh generate-client-keys.sh /home/

RUN mkdir -p /home/server \
	&& mkdir -p /home/client \
	&& chmod +x /home/prepare-server.sh /home/generate-client-keys.sh

RUN /bin/bash /home/prepare-server.sh \
	&& /etc/init.d/rabbitmq-server restart

CMD /bin/bash /home/generate-client-keys.sh && rabbitmq-server
#sleep infinity
