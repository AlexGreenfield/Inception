## Commands
### [docker build](https://docs.docker.com/reference/cli/docker/image/build/)
| Syntax      | Description                                               |
| ----------- | --------------------------------------------------------- |
| Description | Create and run a new container from an image              |
| Usage       | `docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]` |
| Aliases     | `docker run`                                              |
#### Description
The `docker run` command runs a command in a new container, pulling the image if needed and starting the container.

You can restart a stopped container with all its previous changes intact using `docker start`. Use `docker ps -a` to view a list of all containers, including those that are stopped.
#### Most used options

| Option | Default | Description |
|---|---|---|
|[`-d`](https://docs.docker.com/reference/cli/docker/container/run/#detach)||Run container in background and print container ID|
|[`--name`](https://docs.docker.com/reference/cli/docker/container/run/#name)||Assign a name to the container|
|[`--rm`](https://docs.docker.com/reference/cli/docker/container/run/#rm)||Automatically remove the container and its associated anonymous volumes when it exits|

### [docker run](https://docs.docker.com/reference/cli/docker/container/run/)
| Syntax  | Description |
|---|---|
|Description|Create and run a new container from an image|
|Usage|`docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]`|
|Aliases|`docker run`|
#### Description
The `docker run` command runs a command in a new container, pulling the image if needed and starting the container.

You can restart a stopped container with all its previous changes intact using `docker start`.
Use `docker ps -a` to view a list of all containers, including those that are stopped.

#### Options

| Option | Default | Description |
|--------|---------|-------------|