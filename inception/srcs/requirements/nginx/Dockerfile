# Using debian penultimate stable version, bookworm (12). Trixie(13) is the latest!
FROM debian:bookworm

# Let's update all the packages
RUN apt update && apt upgrade

## And install NGINX! (note the -y flag for prompt forwarding)
RUN apt install nginx -y

# Let's just install the best text editor in the world and curl
RUN apt install vim -y && apt install curl -y