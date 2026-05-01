## Overview
When you use a bind mount, a file or directory on the host machine is mounted from the host into a container. By contrast, when you use a volume, a new directory is created within Docker's storage directory on the host machine. Docker creates and maintains this storage location, but containers access it directly using standard filesystem operations.
## Documentation
- [Bind mount](https://docs.docker.com/engine/storage/bind-mounts/)