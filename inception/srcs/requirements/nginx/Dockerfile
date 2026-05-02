
# ---Basic setup---

# Using debian penultimate stable version, bookworm (12). Trixie(13) is the latest!
FROM debian:bookworm

# Let's update all the packages
RUN apt update -y && apt upgrade -y

# Let's just install the best text editor in the world and curl
RUN apt install vim -y && apt install curl -y

## And install NGINX! (note the -y flag for non-interactive installation)
RUN apt install nginx -y

# ---TLS install---

# First, let's create a directory where to store the certificate and the key for a secure connection
RUN mkdir -p /etc/nginx/ssl

# Let's install OpenSSL...
RUN apt install openssl -y

# ... and build an TLS certificate (nodes flag for non-interactive)
RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=SP/ST=CAM/L=Madrid/O=42/OU=42/CN=acastrov.42.fr/UID=acastrov"


# ---NGINX .conf---

# Let's make a folder where to store config files
RUN mkdir -p /var/run/nginx

# And copy our own .conf from our host to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Let's get permissions for our www files
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# And let's run this container! 
#We set up `-g (global config) daemon off` to keep main process (DIP 1) running in foreground
# Otherwise, the container will close!
CMD [ "nginx", "-g", "daemon off;" ]

