# Using debian penultimate stable version, bookworm (12). Trixie(13) is the latest!
FROM debian:bookworm

# Let's update all the packages
RUN apt update -y && apt upgrade -y

# Let's just install the best text editor in the world and curl
RUN apt install vim -y && apt install curl -y

# Let's instal MariaDB
RUN apt-get install mariadb-server -y

# We use default mariadb.conf, but it can be change any moment
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# Finally, let's copy the script for setting up MariaDB
COPY tools/init_db.sh /init_db.sh
RUN chmod +x /init_db.sh

# And run it at entrypoint
CMD ["/init_db.sh"]