#!/bin/bash

# Let's start sql service in the background
echo "Setting up MariaDB"
#service mysql start;
mysqld_safe --user=mysql &

until mysqladmin ping -h localhost --silent; do
  sleep 1
done

# Let's create of database, taking for name the SQL_DATABASE from .env
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Now let's create an user, same recipe for database with .env in mind
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# And change the password to this root user
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Let's reload the privileges config
mysql -e "FLUSH PRIVILEGES;"

# And lets reset MySQL so the effects take place
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
exec mysqld_safe