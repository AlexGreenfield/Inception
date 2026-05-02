# Using debian penultimate stable version, bookworm (12). Trixie(13) is the latest!
FROM debian:bookworm

# Let's update all the packages
RUN apt update -y && apt upgrade -y


# Let's get php and mariadb-clien
RUN apt-get install -y\
	php7.3\
	php-fpm\
	php-mysql\
	mariadb-client

# Let's get wget, a tool that we will need to install WordPress via HTTPS...
RUN apt-get -y install wget