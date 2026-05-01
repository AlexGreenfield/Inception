## Overview
## Commands
### Build a container from an image and run it

#### [docker build](https://docs.docker.com/reference/cli/docker/buildx/build/)

**Description:** Start a build

**Usage:** `docker buildx build [OPTIONS] PATH | URL | -`

**Aliases:** `docker build`, `docker builder build`, `docker image build`, `docker buildx b`

The `docker buildx build` command starts a build using BuildKit.

**Options**

| Option | Default | Description |
|--------|---------|-------------|

#### [docker run](https://docs.docker.com/reference/cli/docker/container/run)
**Description:** Create and run a new container from an image

**Usage:** `docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]`

**Aliases:** `docker run`

The `docker run` command runs a command in a new container, pulling the image if needed and starting the container.

You can restart a stopped container with all its previous changes intact using `docker start`. Use `docker ps -a` to view a list of all containers, including those that are stopped.

**Options**

| Option                                                                       | Default | Description                                                                           |
| ---------------------------------------------------------------------------- | ------- | ------------------------------------------------------------------------------------- |
| [`-d`](https://docs.docker.com/reference/cli/docker/container/run/#detach)   |         | Run container in background and print container ID                                    |
| [`--name`](https://docs.docker.com/reference/cli/docker/container/run/#name) |         | Assign a name to the container                                                        |
| [`--rm`](https://docs.docker.com/reference/cli/docker/container/run/#rm)     |         | Automatically remove the container and its associated anonymous volumes when it exits |
### Manage containers
#### [docker ps](https://docs.docker.com/reference/cli/docker/container/ls/)
#### docker container start
#### docker container stop
#### docker container kill

## References
## Documentation
