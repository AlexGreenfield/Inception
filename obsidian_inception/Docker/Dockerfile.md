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

**`RUN <command>`:** Allows you to run a command on your virtual machine. The `RUN` instruction is used in `Dockerfiles` to execute commands that build and configure the [[Docker Image]]. These commands are executed during the image build process, and each `RUN` instruction creates a new layer in the [[Docker Image]]. For example, if you create an image that requires specific software or libraries installed, you would use RUN to execute the necessary installation commands. In general, the first RUN provided in the Dockerfile consist of updating your VM's resources, such as apk, or adding basic utilities like vim , curl or sudo .

**`COPY <host-path> <image-path>`:**  this instruction tells the builder to copy files from the host and put them into the container image. You simply specify where your file to copy is located from the directory where your Dockerfile is located, and then where you want to copy it in your virtual machine.

**`EXPOSE <port-number>`:** this instruction sets configuration on the image that indicates a port the image would like to expose. Note that he instruction `EXPOSED` informs Docker that the container is listening on the specified network ports at runtime. `EXPOSED` does not make the container's ports accessible to the host. Instead, it functions as a type of documentation between the person who builds the image and the person who runs the container, about which ports are intended to be published. To publish the port when running the container, use the -p flag on docker run to publish and map one or more ports, or the -P flag to publish all exposed ports and map them to high-order ports.

**`CMD`:** The `CMD` instruction specifies the default command to run when a container is started from the Docker image. If no command is specified during the container startup (i.e., in the `docker run` command), this default is used. `CMD` can be overridden by supplying command-line arguments to `docker run`. `CMD` is useful for setting default commands and easily overridden parameters. It is often used in images as a way of defining default run parameters and can be overridden from the command line when the container is run.  There can only be one `CMD` instruction in a `Dockerfile`. If you list more than one CMD, only the last one takes effect.You can specify CMD instructions using shell or exec forms:
- `CMD ["executable","param1","param2"]` (exec form) 
- `CMD ["param1","param2"]` (exec form, as default parameters to ENTRYPOINT)
- `CMD command param1 param2` (shell form)
	

**`ENTRYPOINT`** The ENTRYPOINT instruction sets the default executable for the container. Any arguments supplied to the docker run command are appended to the ENTRYPOINT command. Note: Use ENTRYPOINT when you need your container to always run the same base command, and you want to allow users to append additional commands at the end. One caveat is that ENTRYPOINT can be overridden on the docker run command line by supplying the --entrypoint flag. ENTRYPOINT has two possible forms, shell or exec forms:
- `ENTRYPOINT ["executable", "param1", "param2"]` (exec form)
- `ENTRYPOINT command param1 param2` (shell form)

** A note for `CMD` and `ENTRYPOINT`: ** 


## Documentation
- [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)
- [Writing a Dockerfile](https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/) 
## References
-  [Grademe Inception Tutorial](https://tuto.grademe.fr/inception/)