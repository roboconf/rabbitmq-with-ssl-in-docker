# docker-rabbitmq-ssl

This repository has as goal to build a rabbitmq container with SSL. 
## To build this image:
1. Go to `tests` directory:  ``cd tests``
2. Run the script `build.sh`: ``./build.sh``

The generated image contains SSL certificates on client side in `/home/client`. This directory is mounted as a volume to allowing the sharing of certificates.


