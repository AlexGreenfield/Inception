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

# ... and download or image of WordPress. 
# We will download 6.9.3 (note that latest is 6.9.4)
# Also, with the -P (--directory-prefix) flag we choose where to download it
# We will set /var/www as the location root of our nginx server
RUN wget https://wordpress.org/wordpress-6.9.3.tar.gz -P /var/www

# Let's un-tar this!
RUN cd /var/www && tar -xzf wordpress-6.9.3.tar.gz && rm wordpress-6.9.3.tar.gz

# And give it the proper permissions
RUN chown -R root:root /var/www/wordpress

