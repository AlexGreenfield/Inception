## Overview
With Docker Compose you use a YAML configuration file, known as the [Compose file](https://docs.docker.com/compose/intro/compose-application-model/#the-compose-file), to configure your application’s services, and then you create and start all the services from your configuration with the [Compose CLI](https://docs.docker.com/compose/intro/compose-application-model/#cli).

The Compose file, or `compose.yaml` file, follows the rules provided by the [Compose Specification](https://docs.docker.com/reference/compose-file/) in how to define multi-container applications. This is the Docker Compose implementation of the formal [Compose Specification](https://github.com/compose-spec/compose-spec).

## Commands
-  `compose up`
-  `compose down`
-  `compose logs`
-  `compose ps`

## Illustrative example

Consider an application split into a frontend web application and a backend service.

The frontend is configured at runtime with an HTTP configuration file managed by infrastructure, providing an external domain name, and an HTTPS server certificate injected by the platform's secured secret store.

The backend stores data in a persistent volume.

Both services communicate with each other on an isolated back-tier network, while the frontend is also connected to a front-tier network and exposes port 443 for external usage.

![Example of a docker compose application](https://docs.docker.com/compose/images/compose-application.webp)

The example application is composed of the following parts:
- Two services, backed by Docker images: webapp and database
- One secret (HTTPS certificate), injected into the frontend
- One configuration (HTTP), injected into the frontend
- One persistent volume, attached to the backend
- Two networks

``` YAML
services:
  frontend:
    image: example/webapp
    ports:
      - "443:8043"
    networks:
      - front-tier
      - back-tier
    configs:
      - httpd-config
    secrets:
      - server-certificate

  backend:
    image: example/database
    volumes:
      - db-data:/etc/data
    networks:
      - back-tier

volumes:
  db-data:
    driver: flocker
    driver_opts:
      size: "10GiB"

configs:
  httpd-config:
    external: true

secrets:
  server-certificate:
    external: true

networks:
  # The presence of these objects is sufficient to define them
  front-tier: {}
  back-tier: {}
```
## 42 Example
In Webserv, we have to create different images that have to talk between each other: `NGINX` for the backend, WordPress for the frontend, and MariaDB for the database. So, we have to create this three images and setup a `YAML` file that starts them. Here's an example of how this `YAML` file could look like: 

```YAML
version: "3"

services:
nginx:
	build: requirements/website/ 
	env_file: .env
	container_name: website
	ports:
	- "80:80"
	restart: always
nginx:
	build: requirements/intra/
env_file: .env
	container_name: intra
	ports:
	- "80:80"
	restart: always 
mariadb:
	container_name: badgeuse
	build: mariadb
	env_file: .env
	restart: always
```



## Docker Compose Syntax
- `Version`: specifies 


## Documentation
- [How Compose works](https://docs.docker.com/compose/intro/compose-application-model/)
- [Docker Compose Quickstart](https://docs.docker.com/compose/gettingstarted/)
- [Compose file reference](https://docs.docker.com/reference/compose-file/)
- [docker compose commands](https://docs.docker.com/reference/cli/docker/compose/)
## References
-  [Simplifying Multi-Container Development with Docker Compose ](https://dev.to/mayankcse/simplifying-multi-container-development-with-docker-compose-4adb)

