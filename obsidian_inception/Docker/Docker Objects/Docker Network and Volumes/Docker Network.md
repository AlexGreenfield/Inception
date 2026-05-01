## Overview
Container networking refers to the ability for a [[Docker Container]] to connect to and communicate with each other, and with non-Docker network services.

Containers have networking enabled by default, and they can make outgoing connections. A container has no information about what kind of network it's attached to, or whether its network peers are also Docker containers. A container only sees a network interface with an IP address, a gateway, a routing table, DNS services, and other networking details.

### Default network

When Docker Engine on Linux starts for the first time, it has a single built-in network called the **"default bridge" network**. When you run a container without the `--network` option, it is connected to the default bridge.

Containers attached to the default bridge have access to network services outside the Docker host. They use "masquerading" which means, if the Docker host has Internet access, no additional configuration is needed for the container to have Internet access.

For example, to run a container on the default bridge network, and have it ping an Internet host:

```shell
docker run --rm -ti busybox ping -c1 docker.com
PING docker.com (23.185.0.4): 56 data bytes
64 bytes from 23.185.0.4: seq=0 ttl=62 time=6.564 ms

--- docker.com ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 6.564/6.564/6.564 ms
```

### User-defined networks
With the default configuration, containers attached to the default bridge network have unrestricted network access to each other using container IP addresses. **They cannot refer to each other by name**.

It can be useful to **separate groups of containers** that should have full access to each other, but restricted access to containers in other groups.

You can create custom, user-defined networks, and connect groups of containers to the same network. **Once connected to a user-defined network, containers can communicate with each other using container IP addresses or container names**.

The following example creates a network using the `bridge` network driver and runs a container in that network:
```shell
docker network create -d bridge my-net
docker run --network=my-net -it busybox
```
## Commands
- `docker network ls`: list all networks.
- `docker network inspect <network-name>`: see which containers are connected to an specific network.