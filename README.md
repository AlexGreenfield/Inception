*This project has been created as part of the 42 curriculum by acastrov*
# Readme
## Description
Webserv is a 42 School projects aimed to learn the basics of [containerization](https://www.ibm.com/think/topics/containerization): the process to create and develop applications into isolated packages which contains all the necessary code, dependencies and libraries to deploy a program across various environments and ensure portability regardless of the system of the end user. In other words, a way to solve the "It works in my machine!" problem.

For this task we will use [Docker](https://www.docker.com/), one of the most established and well documented platforms for development (although there are other open source alternatives, like [Podman](https://podman.io/). In this case, we will have to use three different services to deploy a basic blog:
- WordPress: one of the most used CMS (Content Manager System) to manage the contents of your blog.
- MariaDB: a free open source database for storing the contents of your blog.
- NGINX: a free open source software to deploy an static HTTP web server.

The goal of this project is to deploy all of this services individually as their own Docker container (so everyone have it own dependencies, resources and configuration at run time) and make them interact with each and store data other using other Docker tools, like Docker network and Docker volumes. At the end we will we able to deploy our own blog using Docker Compose, a tool designed to manage multiple containers and ensure the proper implementation of the different services as a whole. Let's get started!

## Project Description
### Main Design Choices
The main architecture of this project is defined by the subject, so it looks something like this:

![Inception Architecture](inception_architecture.png)

- Containers
	- A Docker container with NGINX with TLSv.1.3
	- A Docker container with Wordpress + php-fpm
	- A Docker container with MariaDB only, without nginx
- Database
	- Wordpress database (users)
	- Wordpress website files (html)
- Network
	- Expose internal port 9000 for Wordpress
	- Expose internal port 3306 for MariaDB
	- Expose external port 443 to access to NGINX via HTTPS

As the subject ask you to create two different WordPress users with specific credentials and also be able to change any of this ports, all the containers include some entrypoints where to change different configurations:
- MariaDB:
	- A configuration file (50-server.cnf) to change listening and bind port.
	- A script to do an initial user setup when making the database.
- NGINX:
	- A configuration file (nginx.conf) where to specify listening ports, TLsV protocols and php routing
- WordPress
	- A default www.conf.in in case any changes are necessary
	- A script (auto_config.sh) to load any custom www.conf.in into the container and basic setup for WordPress (as mandatory)

### Virtual Machines vs Docker
When we talk about running a software with their own dependencies, libraries, environment and resources, maybe one thought could have crossed your mind: why not use a Virtual Machine and call it a day?

Well, while both a Virtual Machine and a container are virtualization technologies, they differ in some aspects. A Virtual Machine virtualize all the components of a PC, including the hardware and the full OS. They are resource intensive and pretty much overkill for the principles of containerization: ensuring portability using isolated packages which contains all the fundamental pieces for a application to run. 

Containers are much lightweight than Virtual Machines because they do not need to virtualize the machine as a whole: they only virtualize the software layers above the operating system level, not hardware layers or kernel. In other words, they only take the binaries and libraries they will use, no need to package a complete OS. Neat!

### Secrets vs Environment Variables
Containers not only need libraries and binaries, they may also need some additional info, like usernames, path to files or even passwords. Some of this information can be exported inside the container as an environmental variables, like an specific $USER or an $EMAIL. Just specify the environments you wanna export in the docker-compose.yml file or put them in a separate .env file, and Docker Compose will manage to put them into it's respective Docker container. One thing less to care about!

But beware! What happens to sensible data, like passwords or other personal info? If you just put them into a .env file, it will be visible by everyone! They will also appear in Docker logs or in application errors That's a no go and a very high security risk. Remember that commit where you pushed some sensible data to the repository? I hope that you deleted that commit all together and not just removed that information on a new push. Because if not, that data will be public to anyone that's rogue enough to ditch a little bit in your repository :).

That's what secrets are for, you silly! With secrets we can tell Docker Compose in which files we store our sensitive data (remember to keep this files private!) and read them only when necessary and with discretion. First, specify which files are secrets in the secrets section of your docker-compose.yml. Then, when you need to retrieve that secret somewhere in your code, just reference it by the rout /run/secrets/filename, like so:
```YAML
db:
    image: postgres:latest
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    secrets:
      - db_password
```
### Docker Network vs Host Network
Once you have set up multiple containers, you will want to them to communicate with each other, right? That's what Docker Network is for! With this tool you can stablish a virtual network so your different containers can interchange data between them and also with non-Docker services..

Docker allows you tou stablish an independent network dedicated to your containers. In this network, a container only sees a network interface with an IP address, a gateway, DNS and other networking details. The default network is called "bridge", which allow the connection between containers and the host network seamless, so no extra configuration is needed for the container to have Internet access. In other words, the "bridge" network provides network isolation, identification of every container with an unique IP, port mapping capacities and less conflicts overall.

But what if you don't want to run your containers on it's own isolated network? Well, with the "host" driver you can remove the barriers between your containers and your host network. In this type of network the container doesn't get its own IP-address, so if you bind a container to port 80, the application will be available on port 80 on the host's IP address. This optimize performance and allows containers to handle a large range of ports, but is less secure and can be prone to more ports conflicts.

### Docker Volumes vs Bind Mounts
When using Docker, you may wanna to store some persisting data in your host machine, like a database of users. There are two different tools for managing data, Docker Volumes and a Bind Mount. With Docker Volumes you can create folders inside your container and organize them with different Docker tools, like the CLI (Command Line Interface). For example, you can create a separate volume, associated it to different containers, and then put that volume down, effectively removing that data from different containers at once.

In the other hand, there are Bind Mounts, where a directory from the host machine is directly mounted from the host into a container. This means that Docker can keep track os this storage location, but it can't manage it via the CLI whatsoever. Only the host can manipulate it using the started filesystem operations. In other words, it's simply a preexisting folder on your host device that you make accessible from within the container.

## Instructions
The subject specifies that this project must be run inside a Virtual Machine. I will leave that step to you (you can check this [guide](https://github.com/Bakr-1/inceptionVm-guide?tab=readme-ov-file)).

The setup is very straightforward, but you will need sudo permissions. First, make sure that you've installed the last version of Docker and Docker Compose in your machine.

```shell
sudo apt update
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker
```

Then, change your /etc/hosts to make a internal routing to `login.42.fr` (use your login, duh).

```
# Standard host addresses
127.0.0.1  localhost
# Add this line with your login
127.0.0.1  login.42.fr
```

That's all the setup your will need for this project. I encourage you to not work from a Virtual Machine (it will very slow and it is pointless). Pick a PC that runs well, do all the project in that computer, and leave the VM for last (you only have to scp the files to that machine). You can also connect it via SSH, so you can still use your own Visual Studio configuration in your host machine. If you have setted up this project well, it should work on any machine... which is exactly the point of using Docker in the first place, duh.

## Resources
### Tutorials
#### General project
- [Grademe Inception Tutorial](https://tuto.grademe.fr/inception/)
- [Ssterdev Part 1](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)
- [Ssterdev Part  2](https://medium.com/@ssterdev/inception-42-project-part-ii-19a06962cf3b)
- [vbachele - Github](https://github.com/vbachele/Inception) 
- [llescure - Github](https://github.com/llescure/42_Inception)
- [Docker NGINX + WordPress + MariaDB Tutorial - Inception42 ](https://dev.to/alejiri/docker-nginx-wordpress-mariadb-tutorial-inception42-1eok)
#### Setting up a VM
- [inceptionVm-guide](https://github.com/Bakr-1/inceptionVm-guide?tab=readme-ov-file) 
- [Vikingu-del Inception-Guide](https://github.com/Vikingu-del/Inception-Guide)
### Articles
#### Docker
- [Getting started with Docker and Kubernetes: A beginners guide](https://www.educative.io/blog/docker-kubernetes-beginners-guide)
#### Docker Compose
-  [Simplifying Multi-Container Development with Docker Compose ](https://dev.to/mayankcse/simplifying-multi-container-development-with-docker-compose-4adb)
#### YAML
- [What is YAML?](https://www.redhat.com/en/topics/automation/what-is-yaml)
### Documentation
#### Docker
- [What is docker?](https://docs.docker.com/get-started/docker-overview/)
#### Docker CLI
- [CLI Cheat Sheet](https://www.docker.com/resources/cli-cheat-sheet/)
#### Docker Images
- [What is an image?](https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-an-image/)
- [Understanding the image layers](https://docs.docker.com/get-started/docker-concepts/building-images/understanding-image-layers/)
#### Dockerfile
- [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)
- [Writing a Dockerfile](https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/) 
### AI Usage
Different AI tools (ChatGPT, Gemini) had been used in this tasks of the projects:
- Search for information relative to Docker, Docker Compose, NGINX, WordPress and MariaDB
- Fixes and installation tips for setting a Debian based Virtual Machine
- Assist in the coding of Dockerfiles and Docker Compose YAML syntax
- Assists and fixes in the scripts and configuration files for the different docker images