## Overview
Dockerfile acts like a Makefile but with instruction to build a Docker image. It specifies which OS the container will use (Alpine is the most used in this regard), which dependencies does it have to install (NGINX MariaDB...) and which commands does the console have to run in order for the program to run properly. Here's a basic Dockerfile implementation for setting up NGINX.

```Dockerfile
FROM		alpine:3.12

RUN			apk update && apk upgrade && apk add	\
							openssl			\
							nginx			\
							curl			\
							vim				\
							sudo

RUN			rm -f /etc/nginx/nginx.conf

COPY		./config/nginx.conf /etc/nginx/nginx.conf
COPY		scripts/setup_nginx.sh /setup_nginx.sh

RUN			chmod -R +x /setup_nginx.sh

EXPOSE		443

ENTRYPOINT	["sh", "setup_nginx.sh"]
```

## Keywords

**`FROM <image>`:** Allows you to tell Docker which OS your virtual machine should run on. This is the first keyword in your Dockerfile and it is mandatory . The most common ones are debian:buster for Debian or alpine:x:xx for Linux .

**`RUN <command>`:** Allows you to run a command on your virtual machine. The equivalent of connecting via ssh, then typing a bash command, such as: echo “Hello World!”. In general, the first RUN provided in the Dockerfile consist of updating your VM's resources, such as apk, or adding basic utilities like vim , curl or sudo .

**`COPY <host-path> <image-path>`:**  this instruction tells the builder to copy files from the host and put them into the container image. You simply specify where your file to copy is located from the directory where your Dockerfile is located, and then where you want to copy it in your virtual machine.

**`EXPOSE <port-number>`:** this instruction sets configuration on the image that indicates a port the image would like to expose. Note that he instruction `EXPOSED` informs Docker that the container is listening on the specified network ports at runtime. `EXPOSED` does not make the container's ports accessible to the host.

## Documentation
- [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)
- [Writing a Dockerfile](https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/) 
## References
-  [Grademe Inception Tutorial](https://tuto.grademe.fr/inception/)