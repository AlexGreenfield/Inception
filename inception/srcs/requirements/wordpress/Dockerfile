# Using debian penultimate stable version, bookworm (12). Trixie(13) is the latest!
FROM debian:bookworm

# Let's update all the packages
RUN apt update -y && apt upgrade -y


# ---Wordpress install---

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


# ---PHP install---

# Let's get php and mariadb-clien
RUN apt-get install -y\
	php7.3\
	php-fpm\
	php-mysql\

COPY conf/www.conf.in /etc/php/8.2/fpm/pool.d/www.conf

# ---WordPress CLI install---

# Let's download the repo for WP-CLI and install the binaries
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp



# --- MariaDB client---

RUN apt-get install -y mariadb-client

